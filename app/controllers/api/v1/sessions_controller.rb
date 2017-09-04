class Api::V1::SessionsController < ApplicationController
  skip_before_action :authorized, only: [:create]

  def create
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      payload = {user_id: @user.id}
      token = issue_token(payload)
      render json: {the_key_to_happiness: token, user_id: @user.id}
    else
      render json: {message: "you ain't allowed inside these doors, son!"}
    end
  end


  def user_id
    !!logged_in ? (render json: {user_id: current_user.id}) : (render json: {user_id: ""})
  end


end
