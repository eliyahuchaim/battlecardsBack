class Character < ApplicationRecord
  belongs_to :user
  has_many :weapon_cards
  has_one :vehicle_card
  has_one :class_card


  def self.create_character(character_params)

    user_id = character_params[:user_id]
    name = character_params[:name]
    avatar = character_params[:avater]

    weapons_arr = [character_params[:weapon_card1], character_params[:weapon_card2], character_params[:weapon_card3]]

    vehicle_card = character_params[:vehicle_card]
    class_card = character_params[:class_card]

    @character = Character.create(user_id: user_id, name: name, avatar: avatar)
      if @character
        weapons_arr.each do |weapon|
          weapon = WeaponCard.find(weapon)
          weapon.update(character_id: @character.id)
        end
        VehicleCard.find(vehicle_card).update(character_id: @character.id)
        ClassCard.find(class_card).update(character_id: @character.id)
      end
    @character
  end

  def self.update_character(character, character_params)
    # byebug
    @character = character

    character_weapons = []
    @character.weapon_cards.each {|card| character_weapons << card.id}

    user_id = character_params[:user_id]
    name = character_params[:name]
    avatar = character_params[:avatar]

    weapons_arr = [character_params[:weapon_card1], character_params[:weapon_card2], character_params[:weapon_card3]]

    vehicle_card = character_params[:vehicle_card]
    class_card = character_params[:class_card]

    @character.update(user_id: user_id, name: name, avatar: avatar)

    character_weapons.each do |weapon|
      if !weapons_arr.include?(weapon)
          WeaponCard.find(weapon).update(character_id: nil)
      end
    end

    weapons_arr.each do |weapon|
      WeaponCard.find(weapon).update(character_id: @character.id)
    end

    if @character.vehicle_card.id != vehicle_card
      VehicleCard.find(@character.vehicle_card.id).update(character_id: nil)
      VehicleCard.find(vehicle_card).update(character_id: @character.id)
    end

    if @character.class_card.id != class_card
      ClassCard.find(@character.class_card.id).update(character_id: nil)
      ClassCard.find(class_card).update(character_id: @character.id)
    end
    @character
  end


  def self.validate_weapon_cards
  end

end
