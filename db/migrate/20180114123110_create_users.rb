class CreateUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :users do |t|
      t.string :user_id
      t.string :nick
      t.string :password
      t.text :memo

      t.timestamps
    end
  end
end
