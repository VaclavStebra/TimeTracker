class AddRateToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :rate, :integer
  end
end
