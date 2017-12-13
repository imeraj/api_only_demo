class Api::V1::WelcomeController < ApplicationController
  def hello
    render json: { message: "hello" }, status: 200
  end
end
