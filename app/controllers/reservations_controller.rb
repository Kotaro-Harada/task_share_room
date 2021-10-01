class ReservationsController < ApplicationController
  before_action :set_q
  def new
  end

  def create
    @reservation = Reservation.new(params.require(:reservation).permit(:start_day,:end_day,:number_of_people,:room_id,:user_id))
    if @reservation.save
      redirect_to rooms_home_path, notice: "room was successfuly reserved."
    else
      redirect_to room_path(@reservation.room_id), alert: @reservation.errors.full_messages
    end
  end

  def edit
  end

  def show
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: "reservation was deleted."
  end

  def index
    if current_user.admin
      @reservation = Reservation.all
    else
      @reservation = current_user.reservations
    end
  end

  def search
    @results = @q.result
  end

  def set_q
    @q = Room.ransack(params[:q])
  end
end
