class Api::v1::CharacterController < ApplicationController



  def index
  end

  def create

  end

  def update
  end

  def show
  end

  def destroy
  end


  private
    def character_params
      params.requrie(:character).permit(:user_id)
    end

end
