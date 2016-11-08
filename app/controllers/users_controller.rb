class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:success] = "Success"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.where(params[:access_token]).first
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:phone_number,:reserves_count,:password,:password_confirmation,:access_token)
  end
end
