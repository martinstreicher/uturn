class GamesController < ApplicationController
  def create
    @name = params[:name]
    @game = @room.game @name

    render(
      template: 'games/show.json.rabl',
      location: game_url(@game.id),
      status:   (!@game.new_record? ? :created : :unprocessable_entity))
  end
  
  def delete
  end
  
  def update
  end
  
  def show
  end
end
