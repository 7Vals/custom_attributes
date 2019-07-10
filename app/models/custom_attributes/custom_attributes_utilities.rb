module CustomAttributes
  module CustomAttributesUtilities
    extend ActiveSupport::Concern

    included do
      after_save :check_duplicate_custom_attributes 
    end

    def check_duplicate_custom_attributes
      return unless self.custom_attribute_defn.unique?
      column_maping = {
        "#{self.owner.class.name}CustomAttributeStringValue"  => 'string_value', 
        "#{self.owner.class.name}CustomAttributeIntegerValue" => 'integer_value', 
        "#{self.owner.class.name}CustomAttributeDoubleValue"  => 'double_value', 
      }

      return if column_maping[self.class.name].blank?
      if self.value.present?
        duplicate_count = self.class.where("#{column_maping[self.class.name]} = ?", self.value).count
        raise StandardError.new("Duplicate value for '#{self.custom_attribute_defn.attr_name}'") if duplicate_count > 1
      end
    end
  end
end