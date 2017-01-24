class CreateInvoices < ActiveRecord::Migration[5.0]
  def change
    create_table :invoices do |t|
    	t.string		:reference,		null: false
    	t.string		:brand_manager,	null: false, limit: 100
    	t.string 	:narration,		null: false, limit: 100
    	t.date		:invoice_date,	null: false
    	t.string		:customer_name,	null: false, limit: 100
      t.float    :amount,   null: false, precision: 10, scale: 2

      t.timestamps
    end
  end
end
