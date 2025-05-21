module CustomAttributes
  module CustomAttributesHelper
    def custom_attribute_types
      types = {
        CustomAttributes::CustomAttribute::TYPE_NUMBER          => "Number",
        CustomAttributes::CustomAttribute::TYPE_DECIMAL         => "Decimal",
#       CustomAttributes::CustomAttribute::TYPE_DATE            => "Date",
#       CustomAttributes::CustomAttribute::TYPE_DATE_TIME       => "Date Time",
        CustomAttributes::CustomAttribute::TYPE_TEXT            => "Single Line Text",
        CustomAttributes::CustomAttribute::TYPE_MULTILINE_TEXT  => "Paragraph Text",
        CustomAttributes::CustomAttribute::TYPE_BOOLEAN         => "Boolean",
        CustomAttributes::CustomAttribute::TYPE_DROPDOWN        => "Dropdown"
      }
    end

    def format_numeric_custom_attr_val(value)
      return value unless value.is_a?(BigDecimal)

      # Here are examples
      # 13.5 → 13.50
      # 13 → 13.00
      # 13.12 → 13.12
      # 13.123445 → 13.123445
      # 13.000001 → 13.000001
      # 13.0000 → 13.00
      num = BigDecimal(value.to_s)
      num.frac.zero? ? format('%.2f', num) : num.to_s('F')
    end
  end
end