module CustomAttributes
  module CustomAttributeDefinition
    extend ActiveSupport::Concern

    included do
      scope :by_sort_order, -> { order('sort_order ASC') }
      scope :visible_to_staff, -> { where(hide_visibility_from_staff: false) }
      validates :attr_name, presence: true, format: { with: /^[a-zA-Z\_\s]+$/, multiline: true, message: 'cannot contain special characters.' }
      validates :default_value, format: { with: /^[\+\-]?\d*\.?\d*$/, multiline: true, message: 'should be a number.' }, if: :number_type?

      def number_type?
        [CustomAttributes::CustomAttribute::TYPE_NUMBER, CustomAttributes::CustomAttribute::TYPE_DECIMAL].include?(attr_type)
      end

      def boolean_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_BOOLEAN
      end

      def dropdown_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_DROPDOWN
      end

      def paragraph_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_MULTILINE_TEXT
      end

      def has_options?
        binding.pry
        dropdown_type?
      end

      def save_custom_attribute(selected_option_label)
        begin
          transaction do
            self.custom_attribute_options = [] unless has_options?
            save!
            if has_options?
              update! default_value: custom_attribute_options.find_by(label: selected_option_label).try(:id)
            end
            true
          end
        rescue ActiveRecord::ActiveRecordError => e
          false
        end
      end

      def update_custom_attribute(custom_attribute_params, selected_option_label)
        begin
          transaction do
            update!(custom_attribute_params)
            if has_options?
              update! default_value: custom_attribute_options.find_by(label: selected_option_label).try(:id)
            end
            true
          end
        rescue ActiveRecord::ActiveRecordError => e
          false
        end
      end

      def default_option
        custom_attribute_options.find_by(id: default_value)
      end
    end
  end
end