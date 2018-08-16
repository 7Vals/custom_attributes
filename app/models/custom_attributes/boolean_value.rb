module CustomAttributes
  module BooleanValue
    def value=(newVal)
      self.boolean_value = newVal
    end

    def value
      unless boolean_value.nil?
        boolean_value ? "Yes" : "No"
      end
    end
  end
end