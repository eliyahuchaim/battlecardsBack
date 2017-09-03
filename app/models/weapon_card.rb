class WeaponCard < ApplicationRecord
  belongs_to :user
  belongs_to :character, optional: true
  belongs_to :weapon_card_type
end
