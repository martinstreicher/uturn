require 'redis'
require 'redis/objects'

class Play
  NULL = 0.0
  include Redis::Objects

  hash_key    :answers
  sorted_set  :scores
  set         :users
  sorted_set  :votes

  def id
    UUID.generate :compact
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
