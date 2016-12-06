class StaticPagesController < ApplicationController
  def home
    @reservation = current_user.reservations.build if user_signed_in?
    @my_reservations = Reservation.where(user_id: current_user.id) if user_signed_in?
    @show_reservations = Reservation.order(:strat_time)
    @facilities = Facility.all
  end

  def help
  end

  def show
  end

  end
