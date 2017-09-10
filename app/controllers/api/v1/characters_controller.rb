class Api::V1::CharactersController < ApplicationController
  skip_before_action :authorized, only: [:index, :show]


  def index
    render json: Character.all
  end

  def create
    @user_id = current_user.id
    @character = Character.create_character(@user_id, character_params)
      if @character
        render json: {character: @character, character_weapon_cards: @character.weapon_cards, character_vehicle_card: @character.vehicle_card, character_class_card: @character.class_card}
      else
        render json: {status: "boi, something went wrong", code: 400, message: @character.errors.full_messages[0]}
      end
  end

  def update
    byebug
    @character = Character.find(params[:id])
    @user_id = current_user.id
    @character_json = Character.update_character(@user_id, @character, character_params)
      if @character_json
        render json: {character: @character_json, character_weapon_cards: @character_json.weapon_cards, character_vehicle_card: @character_json.vehicle_card, character_class_card: @character_json.class_card}
      else
        render json: {status: "someteeng whant rong son. Wut did u do?", code: 400, message: @character_json.errors.full_messages[0]}
      end
  end

  def show
    @character = Character.find(params[:id])
    render json: {character: @character, character_weapon_cards: @character.weapon_cards, character_vehicle_card: @character.vehicle_card, character_class_card: @character.class_card}
  end

  def destroy

  end


  private
    def character_params
      params.require(:character).permit(:name, :avatar, :weapon_card1, :weapon_card2, :weapon_card3, :vehicle_card, :class_card)
    end

end
