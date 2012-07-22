class GameCommand < Command
  def create(player, subject)
    self.query = {name: subject}
    self.url = rooms_url
    self.verb = :post
  end
  
  def enter(player, subject)
    verb = :post
    url = room_players_url(room_id, player)
  end
  
  def leave
  end
end