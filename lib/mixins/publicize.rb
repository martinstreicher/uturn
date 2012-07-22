module Publicize
  def self.included(base)
    base.instance_eval do
      value :policy
      set :enrollees
    end
    
    base.class_eval do
      def enroll(*ids)
        Array.wrap(ids).flatten.each {|e| enrollees << e}
      end
      
      def enrollment
        enrollees.members
      end
      
      def policy=(*ids)
        enrollees.clear
        enrollees << ids
      end
      
      def privatize!(*ids)
        policy.value = 'private'
        enrollees.clear
        enroll ids
      end

      def private?
        policy.value == 'private'
      end

      def public?
        policy.value == 'public'
      end

      def publicize!
        policy.value = 'public'
        enrollees.clear
      end
    end
  end
end
