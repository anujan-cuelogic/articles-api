class AuthenticationsController < ApplicationController

  require 'json_web_token'
  require 'base64'
    
  def login
    @user = User.find_by_username(params[:username])
    decrypted_password = Base64.decode64(params[:password])

    if @user&.valid_password?(decrypted_password)
      token = JsonWebToken.encode(uuid: @user.uuid)
      render json: {
        user_id: @user.id,
        token: token,
        exp: (Time.now + 2.hours).strftime("%m-%d-%Y %H:%M"),
      }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end
end
