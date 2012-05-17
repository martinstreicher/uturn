class Play < Basis
  include Redis::Objects

  hash_key    :answers
  lock        :roster
  sorted_set  :scores
  set         :users
  sorted_set  :votes

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
