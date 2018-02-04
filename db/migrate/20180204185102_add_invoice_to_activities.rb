class AddInvoiceToActivities < ActiveRecord::Migration[5.1]
  def change
    add_reference :activities, :invoice, foreign_key: true
  end
end
