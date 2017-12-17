class WelcomeController < ApplicationController
  def hello
    @users = User.all
    render "users/index"
  #  render json: { message: "hello" }, status: 200
  end
end
