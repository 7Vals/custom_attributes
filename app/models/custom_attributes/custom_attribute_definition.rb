module CustomAttributes
  module CustomAttributeDefinition
    extend ActiveSupport::Concern
    included do
      scope :by_sort_order, -> { order('sort_order ASC') }
      scope :visible_to_staff, -> { where(hide_visibility_from_staff: false) }
      scope :datebox_attributes, -> { where(attr_type: 'date') }
      validates :attr_name, presence: true, format: { with: /^[a-zA-Z\_\s]+$/, multiline: true, message: 'cannot contain special characters.' }
      validates :default_value, format: { with: /^[\+\-]?\d*\.?\d*$/, multiline: true, message: 'should be a number.' }, if: :number_type?

      def number_type?
        [CustomAttributes::CustomAttribute::TYPE_NUMBER, CustomAttributes::CustomAttribute::TYPE_DECIMAL].include?(attr_type)
      end

      def boolean_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_BOOLEAN
      end

      def date_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_DATE
      end

      def dropdown_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_DROPDOWN
      end

      def multiple_choice_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_MULTIPLE_CHOICE
      end

      def checkbox_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_CHECKBOX
      end

      def paragraph_type?
        attr_type == CustomAttributes::CustomAttribute::TYPE_MULTILINE_TEXT
      end

      def has_options?
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

      def load_resoruce
        respond_to?(:resource_type) ? resource_type : self.class.to_s.underscore.downcase.gsub!('_custom_attribute_definition', '')
      end

      def recurring_custom_attribute
        @recurring_custom_attribute_was = try(:is_recurring_was)
      end

      def update_recurring_custom_attribute
        if date_type? && @recurring_custom_attribute_was.present? && custom_attribute_values.present? && @recurring_custom_attribute_was != is_recurring
          if @recurring_custom_attribute_was && !is_recurring
            custom_attribute_values.update_all(recurring_date_value: nil)
          else
            custom_attribute_values_array = custom_attribute_values.map do |custom_attr_val|
              [custom_attr_val.id, { recurring_date_value: custom_attr_val.date_for_next_alert }] if custom_attr_val.date_time_value.present?
            end
            custom_attribute_values_hash = custom_attribute_values_array.compact.to_h
            resource                     = load_resoruce
            custom_attrubute_value_class = Object.const_get "#{resource.humanize}CustomAttributeValue"
            custom_attrubute_value_class.update(custom_attribute_values_hash.keys, custom_attribute_values_hash.values)
          end
        end
      end
    end
  end
end