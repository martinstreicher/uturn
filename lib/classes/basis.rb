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

  def banned
    booted.members.to_set
  end
  
  def boot(*ids)
    boots = ids.deflate.map(&:to_s)
    roster_lock.lock do
      remainders = self.users.members - boots
      self.users.clear
      self << remainders
      boots.each {|boot| self.booted << boot}
    end
  end
  
  def players
    users.members.to_set
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
