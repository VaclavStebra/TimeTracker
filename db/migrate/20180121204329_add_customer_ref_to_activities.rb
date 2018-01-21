class AddCustomerRefToActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :activities, :customer, foreign_key: true
  end
end
