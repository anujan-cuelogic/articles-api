class AuthenticationsController < ApplicationController

  require 'json_web_token'

  def login
    @user = User.find_by_username(params[:username])
    if @user&.valid_password?(params[:password])
      token = JsonWebToken.encode(uuid: @user.uuid)
      render json: {
        user_id: @user.id,
        user: @user,
        token: token,
        exp: (Time.now + 2.hours).strftime("%m-%d-%Y %H:%M"),
      }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

end
