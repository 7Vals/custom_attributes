module CustomAttributes
  module Setup
    def self.included(base)
      base.extend ClassMethods
    end

    module ClassMethods
      def allows_custom_attributes
        include CustomAttributes
      end
    end
  end
end