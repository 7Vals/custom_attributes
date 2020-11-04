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

      def is_date?(date = date_time_value)
        !!date.to_date rescue false
      end

      def date_for_next_alert
        if !is_date?
          nil
        elsif date_time_value > Date.today
          date_time_value
        else
          time_cycle    = custom_attribute_defn.repeat_cycle.downcase
          divisor       = { day: 1, week: 7, month: 30, year: 365 }[time_cycle.to_sym]
          difference    = (Date.today - date_time_value.to_date).to_i
          cycles_to_add = difference / divisor + 1
          date_time_value + cycles_to_add.send(time_cycle)
        end
      end
    end
  end
end
