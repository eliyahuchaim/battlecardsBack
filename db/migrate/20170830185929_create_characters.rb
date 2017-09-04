class CreateCharacters < ActiveRecord::Migration[5.1]
  def change
    create_table :characters do |t|
      t.integer :user_id
      t.string :name
      t.string :avatar

      t.timestamps
    end
  end
end
