require 'redis'
require 'redis/objects'

class Basis
  include Redis::Objects
  
  lock        :roster
  set         :users
  
  attr_reader :id

  def self.find(id)
    object = self.new(id)
    object.new_record? ? nil : object
  end

  def initialize(id = nil)
    @id = id || UUID.generate
  end
  
  def add_players(*ids)
    roster_lock.lock do
      self << ids
    end
  end
  alias_method :add_player, :add_players

  def new_record?
    players.empty?
  end

  def players
    users.members
  end

  def players=(*ids)
    roster_lock.lock do
      users.clear
      self << ids
    end
  end

  def <<(*ids)
    Array.wrap(ids).flatten.each {|id| users << id}
  end  
end
