module CustomAttributes
  module CustomAttributeOptionValue
    extend ActiveSupport::Concern
    included do
      def display_name
        custom_attribute_option.option
      end
    end
end