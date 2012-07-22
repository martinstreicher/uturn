class Room < Basis
  include Redis::Objects
  include Publicize
  
  value :owner_name
  value :room_name
  list  :room_games
  
  validates :name, presence: true 
  
  def game(moniker)
    Game.create.tap do |new_game| 
      new_game.name = moniker
      room_games << new_game.id 
    end
  end
  
  def games
    room_games.to_set
  end
  
  def name
    room_name.value
  end
  
  def name=(moniker)
    room_name.value = moniker
  end
  
  def owner
    owner_name.value || 'system'
  end
  
  def owner=(moniker)
    owner_name.value = moniker
  end
end
