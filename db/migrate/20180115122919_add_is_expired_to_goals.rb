class AddIsExpiredToGoals < ActiveRecord::Migration[5.1]
  def change
    add_column :goals, :isExpired, :boolean
  end
end
