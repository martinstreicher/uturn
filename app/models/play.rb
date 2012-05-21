class Play < Basis
  include Redis::Objects

  hash_key    :answers
  sorted_set  :scores
  sorted_set  :votes

  def record_answer(player, answer)
    return nil unless (users.member? player) && answer.present?
    answers[player] = answer
  end

  def vote_for(player)
    return nil unless users.member? player
    votes.increment player
  end
end
