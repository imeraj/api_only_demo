class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include ActionController::RequestForgeryProtection
  include ActionView::Rendering
  include CanCan::ControllerAdditions
  include Authenticable

  before_action :set_scout_context

  protect_from_forgery with: :null_session
  skip_before_action :verify_authenticity_token
  respond_to :json

end
