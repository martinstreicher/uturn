class GamesController < ApplicationController
  def create
    @name = params[:name]
    @game = Game.new name: @name
    @game.save

    render(
      template: 'games/show.json.rabl',
      location: room_game_url(@room.id, @game.id),
      status:   (!@game.new_record? ? :created : :unprocessable_entity))
  end
  
  def delete
  end
  
  def update
  end
  
  def show
  end
end
