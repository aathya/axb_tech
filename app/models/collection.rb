class Collection < ApplicationRecord
	belongs_to :invoice, inverse_of: :collections

	validates :invoice, presence: true
	validates :collection_amount, presence: true
	validates :collection_date, presence: true

	before_validation :set_collection_date, on: :create
	before_validation :round_collection_amount
	before_validation :check_amount_exceeds_or_not?

	def set_collection_date
		self.collection_date = Date.today if self.collection_date.blank?
	end

	def round_collection_amount
		self.collection_amount = self.collection_amount.round(2)
	end

	def check_amount_exceeds_or_not?
		return if self.collection_amount.positive?
		if collection_amount_total_match
			return
		else
			errors.add(:error, "Collection amounts exceed amount in Invoice.Please check Invoice.")	
		end
	end

	private

	def collection_amount_total_match
		total_amount = Collection.where(invoice_id: self.invoice_id).map(&:collection_amount).sum
		amount_given_to_customer = Invoice.find_by(id: self.invoice_id).amount
		balance = (amount_given_to_customer) + (total_amount)
		if balance <= 0
			return true
		else
			return false
		end
	end
end
