class ReservationsController < ApplicationController
  def index
  end

  def create
    @reservation = current_user.reservations.build(reservation_params)
    if @reservation.save
      flash[:notice] = "Reserve finished!"
      redirect_to root_path
    else
      render root_path
    end
  end

  def destroy
    @reservation = current_user.reservations.find_by(id: params[:id])
    @reservation.destroy
    flash[:notice] = "Reservation deleted!"
    redirect_to root_path
  end

  private
  def reservation_params
    params.require(:reservation).permit(:strat_time,:end_time)
  end
end
