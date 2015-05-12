class <%= name %>CustomAttributeValue < ActiveRecord::Base
    belongs_to :custom_attribute_defn, class_name: "<%= name %>CustomAttributeDefinition", foreign_key: "<%= singular_name %>_custom_attribute_definition_id"
    include CustomAttributes::CustomAttributeValue

    def self.initialize (custom_attribute_defn)
      if custom_attribute_defn.nil?
        return nil
      end

      type = custom_attribute_defn.attr_type
      custom_attr_value = nil
      if type=='integer'
        custom_attr_value = <%= name %>CustomAttributeIntegerValue.new(custom_attribute_defn: custom_attribute_defn)
      elsif type=='text'
        custom_attr_value = <%= name %>CustomAttributeStringValue.new(custom_attribute_defn: custom_attribute_defn)
      elsif type=='multiline-text'
        custom_attr_value = <%= name %>CustomAttributeStringValue.new(custom_attribute_defn: custom_attribute_defn)
      elsif type=='date'
        custom_attr_value = <%= name %>CustomAttributeDateValue.new(custom_attribute_defn: custom_attribute_defn)
      end

      custom_attr_value
    end
end