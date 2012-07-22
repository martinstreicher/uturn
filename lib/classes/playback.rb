class Playback 
  attr_reader :filename, :script
  
  def initialize(options)
    @file = options[:file]
    @script = File.open(@file) {|f| f.readlines}.map(&:chomp)
  end
  
  def execute(command)
    (player, command, model, arg) = command.split ' '
    klass = "#{model.capitalize}Command".constantize
    klass.new.perform player, command, arg
  end
  
  def run
    script.each do |command|
      execute command
    end
  end
end
