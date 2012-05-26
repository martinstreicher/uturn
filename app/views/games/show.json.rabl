object @game

attributes :name

node {|game| {id: game.uuid.value}}
node {|game| {players: game.players}}
