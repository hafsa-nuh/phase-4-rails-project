class SessionsController < ApplicationController
  skip_before_action :authorize, only: [:create, :destroy]

  # signin
  def create 
    user = User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      # byebug
      session[:user_id] = user.id
      render json: user, status: :created
    else
      render json: { error: "Invalid username or password" }, status: :unauthorized
    end
  end

  # signout
  def destroy
    session.delete :user_id
    head :no_content
  end
end
