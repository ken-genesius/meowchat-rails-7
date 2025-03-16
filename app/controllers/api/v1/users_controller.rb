class Api::V1::UsersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    @users = User.all()
    render json: @users.to_json
  end

  def login
    user = User.find_by_username(params[:username])
    status_code = "200"

    if !user
      user = register(params[:username])
      status_code = "201"
      ActionCable.server.broadcast "chatrooms_channel",
      {
        type: "newUser",
        user: user
      }
    end

    render json: {
      status: status_code,
      user: user
    }
  end

  def sign_up
    user = register(params[:username])
    render json: user.to_json
  end

  private
  def register(username)
    generated_password = Devise.friendly_token.first(8)
    user = User.create!(username: username, password: generated_password)
    user
  end
end
