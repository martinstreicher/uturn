class AnswersController < ApplicationController
  def create
    @answer = params[:answer]
    result  = @play.record_answer @player, @answer
    render(
      text:     @answer, 
      location: play_player_vote_url(@play.id, @player),
      status:   (result ? :created : :unprocessable_entity))
  end
end
