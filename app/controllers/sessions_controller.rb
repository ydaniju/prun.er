# frozen_string_literal: true
class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      flash.now[:success] = 'Successfully signed in'
      sign_in user
      remember user
      session[:id] = user.id
      redirect_to current_user
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    sign_out if signed_in?
    redirect_to root_url
  end

  private

  def current_user
    user_id = session[:user_id]
    @current_user ||= User.find_by(id: user_id)
  end
end
