class CreateUserAddresses < ActiveRecord::Migration[5.1]
  def change
    create_table :user_addresses do |t|
      t.string :address_line
      t.string :address_line_2
      t.string :zip_code
      t.string :city
      t.string :state
      t.string :country
      t.references :user, foreign_key: true
      t.boolean :primary

      t.timestamps
    end
  end
end
