class StaticPagesController < ApplicationController
  def home
    @reservation = current_user.reservations.build if user_signed_in?
    @my_reservations = current_user.reservations if user_signed_in?
  end

  def help
  end
end
