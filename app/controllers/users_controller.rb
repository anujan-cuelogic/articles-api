class UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  before_action :see_params_headers, :authenticate_user!, except: :create
   require 'json_web_token'

  # GET /users
  # GET /users.json
  def index
    @users = if params[:name].present?
      User.where('name ILIKE ?  ', "%#{params[:name].strip}%").order(created_at: :desc)
    else
      User.order(created_at: :desc)
    end
    render json: @users
  end

  # GET /users/1
  # GET /users/1.json
  def show
    render json: @user, include: %w(articles)
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      token = JsonWebToken.encode(uuid: @user.uuid)
      # render json: {
      #   user: @user,
      #   token: token,
      #   exp: (Time.now + 2.hours).strftime("%m-%d-%Y %H:%M"),
      # }, status: :ok
      render json: @user, status: :created, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if @user.update(user_params)
      render :show, status: :ok, location: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by_id(params[:id])
      (render json: {message: 'Invalid ID'}, status: :not_found) if @user.blank?
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if params.dig(:user)
        params.require(:user).permit(:name, :username, :password)
      elsif params.dig(:data, :attributes)
        params.require(:data).require(:attributes).permit(:name, :username, :password)
      end
    end
end
