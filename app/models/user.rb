class User < Core
  include Redis::Objects
  
  value :current_room
  
  def room
    Room.find current_room.value
  end
  
  def room=(room)
    current_room.value = room.id
  end
end
