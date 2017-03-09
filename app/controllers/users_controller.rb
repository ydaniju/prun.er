# frozen_string_literal: true
class UsersController < ApplicationController
  def new
  end

  def show
    @link = signed_in? ? current_user.links.build : Link.new
    if current_user
      @user = current_user
    end
    @links = @user.links.paginate(page: params[:page], per_page: 12)
  end

  def signup
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'Your registration was successful!'
      sign_in(@user)
      redirect_to @user
    else
      render 'signup'
    end
  end

  private

  def user_params
    params.require(:user).permit(
      :username,
      :email,
      :password,
      :password_confirmation
    )
  end
end
