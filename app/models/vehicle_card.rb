class VehicleCard < ApplicationRecord
  belongs_to :user
  belongs_to :character, optional: true
  belongs_to :vehicle_card_type

end
