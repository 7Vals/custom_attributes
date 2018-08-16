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
        CustomAttributes::CustomAttribute::TYPE_BOOLEAN         => "Radio Button"
      }
    end
  end
end