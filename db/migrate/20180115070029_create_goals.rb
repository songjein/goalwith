class CreateGoals < ActiveRecord::Migration[5.1]
  def change
    create_table :goals do |t|
      t.string :body
      t.datetime :from
      t.datetime :to
      t.boolean :isCompleted
      t.references :user, foreign_key: true
      t.string :color
      t.string :weight
      t.integer :counts

      t.timestamps
    end
  end
end
