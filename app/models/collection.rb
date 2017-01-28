class Collection < ApplicationRecord
	belongs_to :invoice, inverse_of: :collections, primary_key: :reference, foreign_key: :reference, class_name: 'Invoice'

	validates :reference, presence: true
	validates :amount, presence: true
	validates :collection_date, presence: true

	before_validation :set_collection_date, on: :create
	before_validation :round_amount
	before_validation :check_amount_exceeds_or_not?

	def set_collection_date
		self.collection_date = Date.today if self.collection_date.blank?
	end

	def round_amount
		self.amount = self.amount.round(2)
	end

	def check_amount_exceeds_or_not?
		return errors.add(:error, "Enter a valid reference.") if self.invoice.nil?
		return if self.amount.positive?
		if amount_total_match
			return
		else
 			errors.add(:error, "Collection amounts exceed amount in Invoice.Please check Invoice.")
		end
	end

	private

	def amount_total_match
		total_amount = Collection.where(reference: self.reference).map(&:amount).sum
		amount_given_to_customer = self.invoice.amount
		balance = (amount_given_to_customer) + (total_amount)
		if balance > 0 && balance >= (self.amount).abs
			return true
		else
			return false
		end
	end
end
