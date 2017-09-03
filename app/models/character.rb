class Character < ApplicationRecord
  belongs_to :user
  has_many :weapon_cards
  has_one :vehicle_card
  has_one :class_card

end
