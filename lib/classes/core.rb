require 'redis'
require 'redis/objects'

class Core
  include Redis::Objects
  include ActiveModel::Validations
  
  value       :uuid
  
  attr_reader :id

  def self.create
    object = self.new
    object.save
    object
  end
  
  def self.find(id)
    object = self.new(id)
    object.new_record? ? nil : object
  end
  
  def initialize(id = nil)
    @id = id || UUID.generate
  end
  
  def new_record?
    uuid.value.blank?
  end

  def save
    uuid.value = @id if self.valid?
  end
  alias_method :save!, :save
end
