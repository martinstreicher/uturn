class Room < Basis
  include Redis::Objects
  
  value :room_name
  list  :room_games
  
  def game(moniker)
    Game.create.tap do |new_game| 
      new_game.name = moniker
      room_games << new_game.id 
    end
  end
  
  def games
    room_games
  end
  
  def name
    room_name.value
  end
  
  def name=(moniker)
    room_name.value = moniker
  end
end
