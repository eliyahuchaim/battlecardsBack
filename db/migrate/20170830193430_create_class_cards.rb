class CreateClassCards < ActiveRecord::Migration[5.1]
  def change
    create_table :class_cards do |t|
      t.integer :user_id
      t.integer :class_type_id
      t.integer :kills
      t.integer :score
      t.integer :time_played

      t.timestamps
    end
  end
end
