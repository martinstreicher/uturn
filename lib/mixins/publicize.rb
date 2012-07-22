module Publicize
  def self.included(base)
    base.instance_eval do
      value :policy
      set :enrollees
    end
    
    base.class_eval do
      def enroll(*ids)
        bomb if public?
        ids.deflate.each {|e| enrollees << e.to_s}
      end
      
      def enrollment
        enrollees.members
      end
      
      def enrollment=(*ids)
        bomb if public?
        enrollees.clear
        enroll ids
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
        policy.value != 'private'
      end

      def publicize!
        policy.value = 'public'
        enrollees.clear
      end
      
      def <<(*ids)
        ids.deflate.map(&:to_s).each {|id| 
          users << id if 
            booted.exclude?(id) && (public? || enrollment.include?(id))}
      end
      
      private
      
        def bomb
          raise Exception, 'not a private room'
        end
    end
  end
end
