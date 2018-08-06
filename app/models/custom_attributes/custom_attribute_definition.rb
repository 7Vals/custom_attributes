module CustomAttributes
  module CustomAttributeDefinition
    extend ActiveSupport::Concern
    included do
      scope :by_sort_order, -> { order('sort_order ASC') }
      validates :attr_name, format: { with: /^[a-zA-Z\_\s]+$/, multiline: true, message: 'cannot contain special characters.' }
      validates :default_value, format: { with: /^[\+\-]?\d*\.?\d*$/, multiline: true, message: 'should be a number.' }, if: :number_type?

      def number_type?
        [CustomAttributes::CustomAttribute::TYPE_NUMBER, CustomAttributes::CustomAttribute::TYPE_DECIMAL].include?(attr_type)
      end

      def boolean_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_BOOLEAN
      end
    end
  end
end