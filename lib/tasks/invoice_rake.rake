namespace :invoice_rake do
  task :create => :environment do
    seed_invoice
  end

  def seed_invoice
    JSON.parse(open("#{Rails.root}/docs/invoice.json").read).each do |invoice_json|
      invoice = Invoice.new(invoice_json)
      invoice.save! if invoice.amount.positive?
    end
  end
end
