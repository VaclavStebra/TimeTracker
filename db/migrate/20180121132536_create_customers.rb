class CreateCustomers < ActiveRecord::Migration[5.1]
  def change
    create_table :customers do |t|
      t.string :name
      t.string :address_line
      t.string :address_line_2
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country

      t.timestamps
    end
  end
end
