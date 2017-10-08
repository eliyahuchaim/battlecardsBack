class Api::V1::UsersController < ApplicationController
  skip_before_action :authorized, only: [:index, :show, :create, :users_characters, :bf1_usernames, :front_end_data, :top_ten_users, :update]


  def index
    render json: User.all
  end

  def top_ten_users
    render json: User.top_ten_users
  end

  def bf1_usernames
    @results = User.get_all_usernames
    render json: {usernames: @results}
  end


  def front_end_data
    @response_data = Fetch.make_fetch("Stats/DetailedStats", params[:platform], params[:username])
    if @response_data
      render json: {userdata: @response_data}
    else
      render json: {message: "error"}
    end
  end


  def create
    platform = set_platform(params[:user][:platform])
    response_data = Fetch.create_player_data("Stats/DetailedStats", platform, params[:user][:bf1_username])
    @user = User.create_user(user_params, platform, response_data)
      if @user
        render json: {user: @user, weapons: @user.weapon_cards, vehicles: @user.vehicle_cards, classes: @user.class_cards}
      else
        render json: {status: "account not created. Repec Wamen or account get not!:,,,,( ", code: 400, message: @user.errors.full_messages[0]}
      end
  end


  def update
    @id = params[:id]
    @user = User.update_user(@id)
    if @user
      @user = User.find(@id)
      # byebug
      render json: {user: @user, weapons: @user.weapon_cards, vehicles: @user.vehicle_cards, classes: @user.class_cards}
    else
      render json: {status: "account not created. Repec Wamen or account get not!:,,,,( ", code: 400, message: @user.errors.full_messages[0]}
    end
  end




  def show
    @user = User.find(params[:id])
      render json: {user: @user, weapons: @user.weapon_cards, vehicles: @user.vehicle_cards, classes: @user.class_cards}
  end

  def users_characters
    @user = User.find(params[:id])
    @info = User.characters_info(@user)
    render json: {characters: @info}
  end



  private

    def set_platform(platform)
        if platform == "pc"
          return 3
        elsif platform == "xbox"
          return 1
        elsif platform == "playstation"
          return 2
      end
    end

    def user_params
      params.require(:user).permit(:name, :username, :password, :platform, :bf1_username)
    end


end
