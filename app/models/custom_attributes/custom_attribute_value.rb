module CustomAttributes
  module CustomAttributeValue
    extend ActiveSupport::Concern
    included do
      
      def name
        custom_attribute_defn.attr_name
      end

    end
  end
end
