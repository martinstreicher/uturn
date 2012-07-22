if ARGV.empty?
  puts 'empty'
  exit 
end

ARGV.each do |file|
  Playback.new(file: file).run
end