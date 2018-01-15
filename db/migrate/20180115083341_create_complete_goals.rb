class CreateCompleteGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :complete_goals do |t|
      t.references :goal, foreign_key: true
      t.references :log, foreign_key: true

      t.timestamps
    end
  end
end
