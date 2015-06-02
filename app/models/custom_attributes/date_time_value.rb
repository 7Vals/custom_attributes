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
      self.date_time_value
    end
  end
end