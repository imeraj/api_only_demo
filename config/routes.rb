require 'api_constraint'
require 'enums'

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  def api_version(version, &routes)
    api_constraint = APIConstraint.new(version: version)
    scope module: "api/v#{version}", constraints: api_constraint,
                                     defaults: { format: :json }, &routes
  end

  get 'hello',  to: 'welcome#hello'

  api_version(APIVersion::V1) do

    post    '/login',   to: 'users/sessions#create'
    delete  '/logout',  to: 'users/sessions#destroy'
    post    '/signup',  to: 'users/users#create'

    resources :users, module: "users", :only => [:show, :index, :destroy, :update] do
      resources :products, :only => [:index]
    end
    resources :products, :only => [:show, :index, :create, :update, :destroy]
  end

  api_version(APIVersion::V2) do
    # currently empty
  end

end
