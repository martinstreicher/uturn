class Game < Basis
  include Redis::Objects
  
  value :population_min
  value :population_max
        
  def initialize(*args)
    if args.first.is_a?(String)
      super args.shift
    else
      super
    end
    
    options = args.shift || {}
    population_min.value = options[:minimum_number_of_players] || 2
    population_max.value = options[:maximum_number_of_players] || 8
  end
  
  def new_record?
    population_max.value.blank?
  end

  def minimum_number_of_players
    population_min.value.to_i
  end
  
  def maximum_number_of_players
    population_max.value.to_i
  end
  
  def number_of_players
    players.size
  end
  
  def full?
    ready = false
    roster_lock.lock do
      ready = players.size == maximum_number_of_players
    end
    ready
  end
  
  def ready? 
    number_of_players > minimum_number_of_players
  end
end
