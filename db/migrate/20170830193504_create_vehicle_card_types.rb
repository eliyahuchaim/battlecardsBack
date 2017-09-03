class CreateVehicleCardTypes < ActiveRecord::Migration[5.1]
  def change
    create_table :vehicle_card_types do |t|
      t.string :name
      t.string :image
      t.string :description

      t.timestamps
    end
  end
end
