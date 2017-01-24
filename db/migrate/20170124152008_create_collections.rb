class CreateCollections < ActiveRecord::Migration[5.0]
  def change
    create_table :collections do |t|
    	t.belongs_to :invoice, 	null: false
    	t.float 	  :collection_amount,	null: false, precision: 10, scale: 2
    	t.date		  :collection_date, 	null:false

      t.timestamps
    end
  end
end
