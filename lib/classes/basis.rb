require 'redis'
require 'redis/objects'

class Basis
  include Redis::Objects
  
  lock        :roster
  value       :uuid
  set         :users
  
  attr_reader :id

  def self.create
    object = self.new
    object.save
    object
  end
  
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
    uuid.value.blank?
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

  def save
    uuid.value = @id
  end
  alias_method :save!, :save
  
  def <<(*ids)
    Array.wrap(ids).flatten.each {|i| users << i}
  end  
end
