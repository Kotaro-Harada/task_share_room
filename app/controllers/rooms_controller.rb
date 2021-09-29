class RoomsController < ApplicationController
  before_action :set_q
  def new
    @room = Room.new
  end

  def create
    @room = Room.new(room_params)
    if @room.save
      redirect_to rooms_home_path, notice: "room was successfuly created."
    else
      render "new"
    end
  end

  def index
    @rooms = Room.all
  end

  def show
    @room = Room.find(params[:id])
    @reservation = Reservation.new

    gon.start_day = Reservation.where(room_id: params[:id]).pluck(:start_day)
    gon.end_day = Reservation.where(room_id: params[:id]).pluck(:end_day)
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    @room =Room.find(params[:id])
    if @room.update(room_params)
      redirect_to rooms_post_path(current_user.id), notice: "Room #{@room.name} was successfuly updated."
    else
      render "edit"
    end
  end

  def destroy
    @room = Room.find(params[:id])
    @room.destroy
    redirect_to rooms_home_path, notice: "Room #{@room.name} was deleted."
  end

  def home
    @results = @q.result
  end

  def search
    @results = @q.result
  end

  def post
    if current_user.admin
      @rooms = Room.all
    else
      @rooms = current_user.rooms
    end
  end

  def set_q
    @q = Room.ransack(params[:q])
  end

  private
    def room_params
      params.require(:room).permit(:name,:introduction,:price,:adress,:photo,:user_id)
    end
end
