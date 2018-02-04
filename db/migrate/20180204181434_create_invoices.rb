class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :user, foreign_key: true
      t.references :user_address, foreign_key: true
      t.references :customer_address, foreign_key: true
      t.datetime :date
      t.integer :total_cost
      t.references :customer, foreign_key: true

      t.timestamps
    end
  end
end
