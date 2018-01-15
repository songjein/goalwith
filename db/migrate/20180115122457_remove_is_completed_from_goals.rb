class RemoveIsCompletedFromGoals < ActiveRecord::Migration[5.1]
  def change
    remove_column :goals, :isCompleted, :boolean
  end
end
