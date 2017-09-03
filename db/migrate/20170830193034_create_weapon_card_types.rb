class CreateWeaponCardTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :weapon_card_types do |t|
      t.string :guid
      t.string :name
      t.string :image
      t.string :description
      t.string :category
      t.integer :ammo_cap
      t.string :ammo_type
      t.integer :rate_of_fire
      t.string :range
      t.integer :number_of_magazines

      t.timestamps
    end
  end
end
