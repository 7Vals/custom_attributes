class <%= name %>CustomAttributeValue < ActiveRecord::Base
    belongs_to :custom_attribute_defn, class_name: "<%= name %>CustomAttributeDefinition", foreign_key: "<%= singular_name %>_custom_attribute_definition_id"
    belongs_to :owner, class_name: "<%= name %>", foreign_key: "<%= singular_name %>_id"
    <% if options.tenant %>
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    # Uncomment the following if you want to define a default_scope instead
    # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
    <% end %>
    include CustomAttributes::CustomAttributeValue

    def self.initialize (custom_attribute_defn, owner)
      if custom_attribute_defn.nil? || owner.nil?
        return nil
      end

      type = custom_attribute_defn.attr_type
      custom_attr_value = nil
      if type==CustomAttributes::CustomAttribute::TYPE_NUMBER
        custom_attr_value = <%= name %>CustomAttributeIntegerValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      elsif type==CustomAttributes::CustomAttribute::TYPE_DECIMAL
        custom_attr_value = <%= name %>CustomAttributeDoubleValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      elsif type==CustomAttributes::CustomAttribute::TYPE_DATE
        custom_attr_value = <%= name %>CustomAttributeDateTimeValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      elsif type==CustomAttributes::CustomAttribute::TYPE_DATE_TIME
        custom_attr_value = <%= name %>CustomAttributeDateTimeValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      elsif type==CustomAttributes::CustomAttribute::TYPE_TEXT
        custom_attr_value = <%= name %>CustomAttributeStringValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      elsif type==CustomAttributes::CustomAttribute::TYPE_MULTILINE_TEXT
        custom_attr_value = <%= name %>CustomAttributeStringValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      end

      custom_attr_value
    end
end