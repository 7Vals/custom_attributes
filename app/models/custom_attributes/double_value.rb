module CustomAttributes
  module DoubleValue
    def value=(newVal)
      if (newVal && newVal.present?)
        self.double_value = newVal.to_f
      else
        self.integer_value = nil
      end
    end

    def value
      self.double_value
    end
  end
end
