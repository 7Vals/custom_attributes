module CustomAttributes
  module IntegerValue
    def value=(newVal)
      if (newVal && newVal.present?)
        self.integer_value = newVal.to_i
      else
        self.integer_value = nil
      end
    end

    def value
      self.integer_value
    end
  end
end
