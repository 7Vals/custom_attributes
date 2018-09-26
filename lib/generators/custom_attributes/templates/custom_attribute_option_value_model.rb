class <%= name %>CustomAttributeOptionValue < ActiveRecord::Base
    include CustomAttributes::CustomAttributeOptionValue
    belongs_to :<%= name %>_custom_attribute_option
    belongs_to :<%= name %>_custom_attribute_value
    has_one    :<%= name %>, through: :<%= name %>_custom_attribute_value
    has_one    :<%= name %>_custom_attribute_definition, through: :<%= name %>_custom_attribute_value

    <% if options.tenant %>
      belongs_to :<%= options.tenant %>_id
      scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
      # Uncomment the following if you want to define a default_scope instead
      # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
    <% end %>
end