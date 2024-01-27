class AddDoneToGoals < ActiveRecord::Migration[7.0]
  def change
    add_column :goals, :done, :integer, default: 0
  end
end
