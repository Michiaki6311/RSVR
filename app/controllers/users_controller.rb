class UsersController < ApplicationController

  def account
    @user = User.find(current_user.id)
    @my_reservations = Reservation.where(user_id: current_user.id) if user_signed_in?
  end

end
