module CustomAttributes
  module CustomAttributeValue
    extend ActiveSupport::Concern
    included do
      
      def name
        custom_attribute_defn.attr_name
      end

      def value
        #TODO: return based on type
        string_value || integer_value
      end

      def value=(newVal)
        #TODO: checks here based on type
        self.string_value = newVal
      end
    end
  end
end
