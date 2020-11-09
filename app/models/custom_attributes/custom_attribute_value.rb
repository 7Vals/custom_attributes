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

      def no_of_days_in_year
        Date.leap?(DateTime.now.year) ? 366 : 365
      end

      def date_for_next_alert
        if date_time_value > Date.today
          date_time_value
        else
          time_cycle    = custom_attribute_defn.repeat_cycle.downcase
          no_of_days    = { day: 1, week: 7, month: Date.today.end_of_month.day, year: no_of_days_in_year }[time_cycle.to_sym]
          cycles_to_add = custom_attribute_defn.repeat_duration * no_of_days
          date_time_value + cycles_to_add.send(time_cycle)
        end
      end
    end
  end
end
