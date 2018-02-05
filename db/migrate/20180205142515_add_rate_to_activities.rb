class AddRateToActivities < ActiveRecord::Migration[5.1]
  def change
    add_column :activities, :rate, :integer
  end
end
