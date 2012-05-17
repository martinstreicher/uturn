class ApplicationController < ActionController::API
  include ActionController::MimeResponds
  include AbstractController::Helpers

  def self.inherit_resources
    InheritedResources::Base.inherit_resources(self)
    initialize_resources_class_accessors!
    create_resources_url_helpers!
  end
end
