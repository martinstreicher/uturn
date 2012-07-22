class Basis < Core
  include Redis::Objects
  
  lock        :roster
  set         :booted
  set         :users
  
  def add_players(*ids)
    roster_lock.lock do
      self << ids
    end
  end
  alias_method :add_player, :add_players

  def boot(*ids)
    boots = ids.deflate.to_set
    roster_lock.lock do
      users -= boots
      booted += boots
    end
  end
  
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
    ids.deflate.map(&:to_s).each {|id| 
      users << id if booted.exclude?(id)}
  end  
end
