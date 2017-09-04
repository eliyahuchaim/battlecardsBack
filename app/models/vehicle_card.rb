class VehicleCard < ApplicationRecord
  belongs_to :user
  belongs_to :character, optional: true
  belongs_to :vehicle_card_type


  def self.create_vehicle_cards(user)
    response = Fetch.make_fetch("Progression/GetVehicles", user.platform, user.bf1_username)
    cleaned_hash = Fetch.flatten_hash(response)
    user_id = user.id

      cleaned_hash["result"].each do |main_scope|
        main_scope["vehicles"].each do |vehicle|

          name = vehicle["name"]
          vehicle_id = VehicleCardType.find_by(name: name).id
          kills = vehicle["stats"]["values"]["kills"].round
          time_played = vehicle["stats"]["values"]["seconds"]
          amount_of_vehicles_destroyed = vehicle["stats"]["values"]["destroyed"]

          VehicleCard.create(user_id: user_id, vehicle_card_type_id: vehicle_id, kills: kills, time_played: time_played, amount_of_vehicles_destroyed: amount_of_vehicles_destroyed)
      end
    end
  end


end
