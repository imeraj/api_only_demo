require 'api_constraint'
require 'enums'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def api_version(version, &routes)
    api_constraint = APIConstraint.new(version: version)
    scope module: "api/v#{version}", constraints: api_constraint,
                                     defaults: { format: :json }, &routes
  end

  api_version(APIVersion::V1) do
    get 'hello',  to: 'welcome#hello'

    devise_for :users, skip: :all
    devise_scope :user do
      post    'login',   to: 'users/sessions#create'
      delete  'logout',  to: 'users/sessions#destroy'

      post    'signup', to: 'users/registrations#create'
    end



  end

  api_version(APIVersion::V2) do
    # currently empty
  end

end
