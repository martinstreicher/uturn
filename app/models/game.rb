class Game < Basis
  include Redis::Objects
  
  value :game_name
  list  :plays
  value :population_min
  value :population_max
        
  def initialize(*args)
    if args.first.is_a?(String)
      super args.shift
    else
      super nil
    end
    
    options = args.shift || {}
    game_name.value = options[:name] || 'New game'
    population_min.value = options[:minimum_number_of_players] || 2
    population_max.value = options[:maximum_number_of_players] || 8
  end

  def full?
    ready = false
    roster_lock.lock do
      ready = players.size == maximum_number_of_players
    end
    ready
  end
    
  def minimum_number_of_players
    population_min.value.to_i
  end
  
  def maximum_number_of_players
    population_max.value.to_i
  end

  def play
    plays << (new_play = Play.new)
    new_play
  end
  
  def name
    game_name.value
  end
    
  def number_of_players
    players.size
  end
  
  def ready? 
    number_of_players > minimum_number_of_players
  end
end
