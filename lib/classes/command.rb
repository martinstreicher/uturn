require 'httpclient'

HOST = 'localhost'
PORT = 3000

class Command
  include Uturn::Application.routes.url_helpers
  
  attr_accessor :query, :url, :verb

  def initialize
    default_url_options[:host] = HOST
    default_url_options[:port] = PORT
  end
    
  def perform(player, action, subject)
    self.send action, player, subject
    self.query ||= {}
    puts "Request: #{verb} #{url}"
    response = HTTPClient.new.send verb, url, query
    puts "Response: " + response.body
  end
end
