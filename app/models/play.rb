class Play < Basis
  include Redis::Objects

  hash_key    :game_answers
  sorted_set  :game_votes

  def answers=(answers)
    game_answers = answers
  end
  
  def answers
    game_answers
  end
  
  def record_answer(player, answer)
    return nil unless (users.member? player) && answer.present?
    game_answers[player] = answer
  end

  def vote_for(player)
    return nil unless users.member? player
    game_votes.increment player
  end
  
  def votes
    game_votes
  end
  
  def votes=(tally)
    votes = tally
  end
end
