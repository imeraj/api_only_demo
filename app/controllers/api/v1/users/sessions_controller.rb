class Api::V1::Users::SessionsController < ApplicationController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :ensure_params_exist, only: :create
  before_action :authenticate_with_token, only: :destroy

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    resource = User.find_for_database_authentication({:email => params[:session][:email].downcase})
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:session][:password])
      resource.authentication_token = User.generate_authentication_token!
      resource.save!
      @auth_token = resource.authentication_token
      render "sessions/create", :status => :success
    else
      invalid_login_attempt
    end
  end

  # DELETE /resource/sign_out
  def destroy
      current_user.authentication_token = User.generate_authentication_token!
      current_user.save!
      sign_out
      render "base", :status => :success
  end

  protected
  def ensure_params_exist
    return unless params[:session][:email].blank? or params[:session][:password].blank?
    @message = "Missing email or password."
    render "errors/base", :status => :unprocessable_entity
  end

  def invalid_login_attempt
    @message = "Email of password is invalid."
    render "errors/base", :status => :unauthorized
  end

end
