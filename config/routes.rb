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
  end

  api_version(APIVersion::V2) do
    # currently empty
  end

end
