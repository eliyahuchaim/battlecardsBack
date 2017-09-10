class Api::V1::CardTypesController < ApplicationController
  skip_before_action :authorized, only: [:index]


  def index
    render json: {weaponCardTypes: WeaponCardType.all, vehicleCardTypes: VehicleCardType.all, classCardTypes: ClassType.all}
  end





end
