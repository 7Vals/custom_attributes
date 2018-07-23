module CustomAttributes
  module BooleanValue
    def value=(newVal)
      if !newVal.nil?
        self.boolean_value = newVal
      else
        self.boolean_value = nil
      end
    end

    def value
      if boolean_value.nil?
        "--"
      else
        boolean_value ? "Yes" : "No"
      end
    end
  end
end