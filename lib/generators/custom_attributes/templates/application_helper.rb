module CustomAttributes
  module CustomAttributesHelper
    def custom_attribute_types
      types = {
        CustomAttribute::TYPE_NUMBER          => "Number",
        CustomAttribute::TYPE_DECIMAL         => "Decimal",
#        CustomAttribute::TYPE_DATE            => "Date",
#        CustomAttribute::TYPE_DATE_TIME       => "Date Time",
        CustomAttribute::TYPE_TEXT            => "Single Line Text",
        CustomAttribute::TYPE_MULTILINE_TEXT  => "Paragraph Text"
      }
    end
  end
end