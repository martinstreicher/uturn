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
    @name = params[:name]
    if @room.games.include?(@game.id)
      @game.name = @name
      show
    else
      render text: params[:game_id], status: :not_found
    end
  end
  
  def show
    if @game
      render(
        template: 'games/show.json.rabl',
        location: game_url(@game.id),
        status:   (!@game.new_record? ? :ok : :unprocessable_entity))    
    else
      render text: params[:game_id], status: :not_found
    end
  end
end
