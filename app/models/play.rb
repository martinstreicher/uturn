require 'redis'
require 'redis/objects'

class Play
  NULL = 0.0
  include Redis::Objects

  hash_key    :answers
  lock        :roster
  sorted_set  :scores
  set         :users
  sorted_set  :votes

  attr_reader :id

  def self.find(id)
    object = Play.new(id)
    object.new_record? ? nil : object
  end

  def initialize(id = nil)
    @id = id || UUID.generate
  end

  def add_players(*ids)
    self << ids
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

  def record_answer(player, answer)
    return unless users.member? player
    return if answer.blank?
    answers[player] = answer
  end

  def vote_for(player)
    return unless users.member? player
    votes.increment player
  end
end
