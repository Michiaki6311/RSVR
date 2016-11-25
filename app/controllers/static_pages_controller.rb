class StaticPagesController < ApplicationController
  def home
    @reservation = current_user.reservations.build if user_signed_in?
    @reservations = current_user.reservations.order(created_at: :desc)
  end

  def help
  end
end
