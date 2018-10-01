module CustomAttributes
  module CustomAttributeOptionValue
    extend ActiveSupport::Concern
    included do
      def display_name
        custom_attribute_option.label
      end
    end
  end
end