class <%= name %>CustomAttributeOptionValue < ActiveRecord::Base
  include CustomAttributes::CustomAttributeOptionValue
  belongs_to :custom_attribute_option, class_name: "<%= name %>CustomAttributeOption", foreign_key: "<%= singular_name %>_custom_attribute_option_id"
  belongs_to :custom_attribute_value, class_name: "<%= name %>CustomAttributeValue", foreign_key: "<%= singular_name %>_custom_attribute_value_id"
  has_one    :<%= name %>, through: :<%= name %>_custom_attribute_value
  has_one    :custom_attribute_defn, through: :custom_attribute_value

  <% if options.tenant %>
    belongs_to :<%= options.tenant %>_id
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    # Uncomment the following if you want to define a default_scope instead
    # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
  <% end %>
end