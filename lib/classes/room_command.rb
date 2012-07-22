class RoomCommand < Command
  def create(player, subject)
    self.query = {name: subject, player_id: player}
    self.url = rooms_url
    self.verb = :post
  end
  
  def enter(player, subject)
    verb = :post
    url = room_players_url(room_id, player)
  end
  
  def leave
  end
  
  def show(player, subject)
    self.url = room_url(id: subject)
    self.verb = :get    
  end
end
