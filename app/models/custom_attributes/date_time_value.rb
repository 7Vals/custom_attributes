module CustomAttributes
  module DateTimeValue
    def value=(newVal)
      if (newVal && newVal.present?)
        self.date_time_value = Date.parse(newVal)
      else
        self.date_time_value = nil
      end
    end

    def value
      date_time_value
    end

    def display_value
      date_time_value.try(:to_date).try(:to_s, :long)
    end
  end
end