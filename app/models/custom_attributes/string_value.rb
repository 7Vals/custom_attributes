module CustomAttributeValues
  class StringValue < CustomAttributeValue
    def value=(newVal)
      self.string_value = newVal
    end

    def value
      self.string_value
    end
  end
end