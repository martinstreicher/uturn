class RoomsController < ApplicationController
  def create
    name = params[:name]
    @room = Room.new name
    @room.name = params[:name]
    @room.owner = @player
    @room.save
    
    render(
      template:   'rooms/create.json.rabl',
      location:   room_url(@room.id),
      status:     (@room.new_record? ? :unprocessable_entity : :created))
  end
  
  def show
    if @room
      render(
        template:   'rooms/show.json.rabl',
        location:   room_url(@room.id),
        status:     :ok)
    else
      render(
        text:     '{}',
        status:   :not_found)
    end
  end
  
  def update
  end
end
