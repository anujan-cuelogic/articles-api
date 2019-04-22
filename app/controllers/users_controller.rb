class UsersController < ApplicationController

  require 'json_web_token'

  before_action :authenticate_user!, except: [:create, :profile_picture ]

  before_action :set_user, except: [:index, :create]

  def index
    @users = if params[:name].present?
      User.where('name ILIKE ?  ', "%#{params[:name].strip}%").order(created_at: :desc)
    else
      User.order(created_at: :desc)
    end
    render json: @users
  end

  def show
    render json: @user, include: %w(articles)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      token = JsonWebToken.encode(uuid: @user.uuid)
      render json: @user, status: :created, location: @user
    else
      render json: @user, adapter: :json_api, serializer: ActiveModel::Serializer::ErrorSerializer, status: :unprocessable_entity
    end
  end

  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  def update_profile
    @user.update!(bio: params[:bio])
    @user.save!
    render json: @user
  end

  def profile_picture
    # @user.avatar.attach(params[:avatar])
    if @user.update_attributes(params.permit(:profile_picture))
      render json: @user, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find_by_id(params[:id])
      render json: {message: 'Invalid ID'}, status: :not_found if @user.blank?
    end

    def user_params
      if params.dig(:user)
        params.require(:user).permit(:name, :username, :password)
      elsif params.dig(:data, :attributes)
        params.require(:data).require(:attributes).permit(:name, :username, :password)
      end
    end
end
