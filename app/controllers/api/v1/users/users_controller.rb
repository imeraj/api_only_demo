class Api::V1::Users::UsersController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_with_token, only: [:index, :destroy, :show]

  def index
    @users = User.all
    render "users/index", status: :ok
  end

  def show
    @user = User.find(params[:id])
    if @user
      render "users/show", status: :ok
    else
      render "models/errors", status: :not_found
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
    user = User.find(params[:id])
    if user and current_user and !user.admin? and can? :destroy, user
      user.destroy
      head :no_content
    else
      @message = "Unauthorized"
      render "errors/base", status: :unauthorized
    end
  end

  private
  def user_params
    params.require("user").permit(:username, :email, :password, :password_confirmation)
  end

end
