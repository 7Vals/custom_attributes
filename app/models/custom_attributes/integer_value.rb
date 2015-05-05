module CustomAttributes
  class IntegerValue < CustomAttributeValue
    def value=(newVal)
      self.integer_value = newVal.to_i if newVal
    end

    def value
      self.integer_value
    end
  end
end
