require 'redis'
require 'redis/objects'

class Basis
  attr_reader :id

  def self.find(id)
    object = Play.new(id)
    object.new_record? ? nil : object
  end

  def initialize(id = nil)
    @id = id || UUID.generate
  end
end
