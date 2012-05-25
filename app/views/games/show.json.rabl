object @game

attributes :name

node do |game|
  {id: game.uuid.value}
end
