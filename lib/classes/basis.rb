class Basis < Core
  include Redis::Objects
  
  lock        :roster
  set         :users
  
  def add_players(*ids)
    roster_lock.lock do
      self << ids
    end
  end
  alias_method :add_player, :add_players

  def players
    users.members
  end

  def players=(*ids)
    roster_lock.lock do
      users.clear
    end
    add_players ids
  end

  def <<(*ids)
    Array.wrap(ids).flatten.each {|i| users << i}
  end  
end
