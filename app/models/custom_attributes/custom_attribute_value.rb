module CustomAttributes
  module CustomAttributeValue
    extend ActiveSupport::Concern
    included do
    after_initialize :set_default_value
      
      def name
        custom_attribute_defn.attr_name
      end

      def set_default_value
        return if !self.new_record?
        unless custom_attribute_defn.default_value.blank?
          self.value = custom_attribute_defn.default_value
        end
      end

    end
  end
end
