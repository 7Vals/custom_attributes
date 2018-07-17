module CustomAttributes
  module BooleanValue
    def value=(newVal)
      if (newVal && newVal.present?)
        self.boolean_value = newVal
      else
        self.boolean_value = nil
      end
    end

    def value
      self.boolean_value
    end
  end
end