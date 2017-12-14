class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  include Authenticable

  before_action :configure_permitted_parameters, if: :devise_controller?
  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token

  respond_to :json

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username])
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

end
