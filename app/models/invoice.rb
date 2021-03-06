class Invoice < ApplicationRecord
	has_many  :collections, inverse_of: :invoice, foreign_key: :reference, primary_key: :reference, dependent: :restrict_with_exception

	validates :reference, presence: true, uniqueness: true
	validates :brand_manager, presence: true, length: { in: 3..100 }
	validates :narration, presence: true, length: { in: 3..100 }
	validates :invoice_date, presence: true
	validates :customer_name, presence: true, length: { in: 3..100 }
	validates :amount, presence: true, numericality: { greater_than: 0 }

	before_validation :set_invoice_date, on: :create
	before_validation :set_reference, on: :create
	before_validation :round_amount

	scope :collected_bills, -> { joins(:collections).group("invoices.id").having("(SUM(collections.amount) + (invoices.amount)) = 0") }
	scope :pending_bills, -> { where.not(id: collected_bills.ids) }

	def set_invoice_date
		self.invoice_date = Date.today if self.invoice_date.blank?
	end

	def set_reference
		#have to write reference name logic
		self.reference =  "CES/OWB/#{Date.today.strftime('%y')}-#{(Date.today + 1.year).strftime('%y')}/#{Date.today.strftime('%m')} #{rand(999)}" if self.reference.blank?
	end

	def round_amount
		self.amount = self.amount.round(2) if self.reference.present?
	end
end
