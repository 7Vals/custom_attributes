module CustomAttributes
  module BooleanValue
    def value=(newVal)
      self.boolean_value = newVal
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