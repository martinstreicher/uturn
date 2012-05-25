class ApplicationController < ActionController::API
  before_filter :fetch_params
     
  private
    
    def fetch_params
      instance = params[:controller].try(:singularize)
      klass    = instance.capitalize.try(:safe_constantize)
      id       = params[:id]
      instance_variable_set("@#{instance}", klass.try(:find, id)) if id
      
      params.keys.select {|key| key =~ /_id$/}.
        each do |key|
          instance = key.gsub(/_id$/, '')
          klass    = instance.capitalize.try(:safe_constantize)
          id       = params[key]
          value    = klass ? klass.find(id) : id
          instance_variable_set("@#{instance}", value)
        end
    end
end
