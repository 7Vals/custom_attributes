module CustomAttributes
  module CustomAttributeValue
    extend ActiveSupport::Concern
    included do
      
      def name
        custom_attribute_defn.attr_name
      end

      def apply_default_value
        unless custom_attribute_defn.default_value.blank?
          self.value = custom_attribute_defn.default_value
        end
      end

      def value_or_display_value
        custom_attribute_defn.try(:date_type?) ? try(:display_value) : try(:value)
      end

      def value_present?
        date_time_value.present? || string_value.present? || double_value.present? || integer_value.present? || !boolean_value.nil? || custom_attribute_option_values.any?
      end

      def date_for_next_alert
        if date_time_value > Date.today
          date_time_value
        else
          (recurring_date_value || date_time_value) + custom_attribute_defn.repeat_duration.send(custom_attribute_defn.repeat_cycle.downcase)
        end
      end
    end
  end
end
