class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Success"
      session[:user_id] = @user.id

      redirect_to account_user_url
    else
      flash.now[:danger] = 'invalid account information'
      render 'new'
    end
  end

  def account
    @user = User.find(session[:user_id])
  end

  def show
    @user = User.where(params[:access_token]).first
  end

  def edit
    @user = User.find(session[:user_id])
  end

  def update
    @user = User.find(session[:user_id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to account_user_url
    else
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name,:email,:phone_number,:reserves_count,:password,:password_confirmation,:access_token)
  end
end
