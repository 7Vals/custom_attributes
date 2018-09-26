class <%= name %>CustomAttributeOption < ActiveRecord::Base
    include CustomAttributes::CustomAttributeOption
    belongs_to :custom_attribute_defn, class_name: "<%= name %>CustomAttributeDefinition", foreign_key: "<%= singular_name %>_custom_attribute_definition_id"
    has_many :<%= name %>_custom_attribute_option_values, dependent: :destroy
    <% if options.tenant %>
      belongs_to :<%= options.tenant %>_id
      scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
      # Uncomment the following if you want to define a default_scope instead
      # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
    <% end %>
end