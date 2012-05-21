class AnswersController < ApplicationController
  def create
    @answer = params[:answer]
    result  = @play.record_answer @player, @answer
    render(
      json:     @play, 
      location: play_player_vote_url(@player, @player),
      status:   (result ? :created : :unprocessable_entity))
  end
end
