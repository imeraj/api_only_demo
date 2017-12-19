class Api::V1::Users::UsersController < ApplicationController
  load_and_authorize_resource only: :destroy
  before_action :authenticate_with_token, only: [:index, :destroy, :show, :update]

  def index
    @users = User.all
    render "users/index", status: :ok
  end

  def show
    @user = User.find_by_id(params[:id])
    if @user
      render "users/show", status: :ok
    else
      @message = "User not found."
      render "errors/base", status: :not_found
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render "users/show", status: :created, location: signup_path(@user)
    else
      render "models/errors", status: :unprocessable_entity
    end
  end

  def destroy
    user = User.find_by_id(params[:id])
    if user and current_user and !user.admin? and can? :destroy, user
      user.destroy
      products = user.products.where(published: true)
      products.update_all(published: false) unless products.empty?
      head :no_content
    else
      @message = "Unauthorized"
      render "errors/base", status: :unauthorized
    end
  end

  def update
    if current_user.update(update_user_params)
      @user = current_user
      render "users/show", status: :success
    else
      @message = "Wrong number/format of parameters."
      render "errors/base", status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require("user").permit(:username, :email, :password, :password_confirmation)
  end

  def update_user_params
    params.require("user").permit(:username, :password, :password_confirmation)
  end

end
