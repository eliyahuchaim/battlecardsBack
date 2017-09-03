class CreateWeaponCards < ActiveRecord::Migration[5.1]
  def change
    create_table :weapon_cards do |t|
      t.integer :user_id
      t.integer :weapon_card_type_id
      t.integer :kills
      t.integer :headshots
      t.integer :accuracy
      t.integer :time_played
      t.integer :hits
      t.integer :shots
      t.boolean :unlocked
      t.integer :character_id, default: nil

      t.timestamps
    end
  end
end
