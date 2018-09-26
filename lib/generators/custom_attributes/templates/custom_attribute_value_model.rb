class <%= name %>CustomAttributeValue < ActiveRecord::Base
    include CustomAttributes::CustomAttributeValue
    belongs_to :custom_attribute_defn, class_name: "<%= name %>CustomAttributeDefinition", foreign_key: "<%= singular_name %>_custom_attribute_definition_id"
    belongs_to :owner, class_name: "<%= name %>", foreign_key: "<%= singular_name %>_id"
    has_many   :<%= name %>_custom_attribute_options
    has_many   :<%= name %>_custom_attribute_option_values, dependent: :destroy
    <% if options.tenant %>
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    # Uncomment the following if you want to define a default_scope instead
    # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
    <% end %>

    def self.for_custom_attribute_definition (custom_attribute_defn, owner)
      if custom_attribute_defn.nil? || owner.nil?
        return nil
      end

      custom_attr_value = case custom_attribute_defn.attr_type
      when CustomAttributes::CustomAttribute::TYPE_NUMBER
        <% name %>CustomAttributeIntegerValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      when CustomAttributes::CustomAttribute::TYPE_DECIMAL
        <% name %>CustomAttributeDoubleValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      when CustomAttributes::CustomAttribute::TYPE_DATE, CustomAttributes::CustomAttribute::TYPE_DATE_TIME
        <% name %>CustomAttributeDateTimeValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      when CustomAttributes::CustomAttribute::TYPE_TEXT, CustomAttributes::CustomAttribute::TYPE_MULTILINE_TEXT
        <% name %>CustomAttributeStringValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      when CustomAttributes::CustomAttribute::TYPE_BOOLEAN
        <% name %>CustomAttributeBooleanValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      when CustomAttributes::CustomAttribute::TYPE_DROPDOWN
        <% name %>CustomAttributeDropdownValue.new(custom_attribute_defn: custom_attribute_defn, owner: owner)
      else
        nil
      end

      custom_attr_value
    end
end