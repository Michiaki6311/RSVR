class UsersController < ApplicationController

  def account
    @user = User.find(current_user.id)
  end

end
