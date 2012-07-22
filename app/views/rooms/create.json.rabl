object @room

attributes :name
attributes :owner

node {|room| {id: room.uuid.value}}
