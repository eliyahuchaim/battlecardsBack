class CreateVehicleCards < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_cards do |t|
      t.integer :user_id
      t.integer :vehicle_card_type_id
      t.integer :kills
      t.integer :time_played
      t.integer :amount_of_vehicles_destroyed
      t.integer :character_id, default: nil

      t.timestamps
    end
  end
end
