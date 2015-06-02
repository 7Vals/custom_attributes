module CustomAttributes
  module StringValue
    def value=(newVal)
      if (newVal && newVal.present?)
        self.string_value = newVal
      else
        self.string_value = nil
      end
    end

    def value
      self.string_value
    end
  end
end