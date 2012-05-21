class Play < Basis
  include Redis::Objects

  hash_key    :answers
  sorted_set  :scores
  sorted_set  :votes

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
