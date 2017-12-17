class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  include ActionView::Rendering
  include Authenticable
  include CanCan::ControllerAdditions

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  respond_to :json

end
