class User < ApplicationRecord
  has_secure_password
  has_many :weapon_cards
  has_many :characters
  has_many :vehicle_cards
  has_many :class_cards

end
