require 'redis'
require 'redis/objects'

unless ENV["REDISTOGO_URL"].blank?
  uri = URI.parse(ENV["REDISTOGO_URL"])
  Redis.current = Redis.new(
    :host => uri.host,
    :port => uri.port,
    :password => uri.password)
end
