class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Success"
      sign_in_and_redirect @user
    else
      flash[:danger] = 'invalid account information'
      redirect_to new_user_registration_url
    end
  end

  def account
    @user = current_user
  end

  def show
  end

  def edit
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:phone_number,:reserves_count,:password,:password_confirmation)
  end
end
