class CreateClassTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :class_types do |t|
      t.string :name
      t.string :image

      t.timestamps
    end
  end
end
