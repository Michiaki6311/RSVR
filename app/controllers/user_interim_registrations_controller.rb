class UserInterimRegistrationsController < ApplicationController

  def new
    @user_interim_registration = UserInterimRegistration.new
  end

  def create
    @user_interim_registration = UserInterimRegistration.new(user_params)
    if @user_interim_registration.save
      flash[:success] = "Success"
      redirect_to new_user_interim_registration_url
    else
      flash.now[:danger] = 'invalid account information'
      render 'new'
    end
  end

  private
  def user_params
    params.require(:user_interim_registration).permit(:email,:access_token)
  end
end
