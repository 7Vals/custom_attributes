module CustomAttributes
  module StringValue
    def value=(newVal)
      self.string_value = newVal
    end

    def value
      self.string_value
    end
  end
end