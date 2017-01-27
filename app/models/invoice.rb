class Invoice < ApplicationRecord
	has_many  :collections, inverse_of: :invoice, foreign_key: :reference, primary_key: :reference, dependent: :restrict_with_exception

	validates :reference, presence: true, uniqueness: true
	validates :brand_manager, presence: true, length: { in: 3..100 }
	validates :narration, presence: true, length: { in: 3..100 }
	validates :invoice_date, presence: true
	validates :customer_name, presence: true, length: { in: 3..100 }
	validates :amount, presence: true

	before_validation :set_invoice_date, on: :create
	before_validation :set_reference, on: :create
	before_validation :round_amount

	def set_invoice_date
		self.invoice_date = Date.today if self.invoice_date.blank?
	end

	def set_reference
		#have to write reference name logic
		self.reference =  SecureRandom.hex(8) if self.reference.blank?
	end

	def round_amount
		self.amount = self.amount.round(2) if self.reference.present?
	end
end
