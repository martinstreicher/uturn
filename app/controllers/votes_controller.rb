class VotesController < ApplicationController
  def create
    if (votes = @play.vote_for(@player))
      render text: votes, status: :ok
    else
      render text: 'NOK', status: :unprocessable_entity
    end
  end
end
