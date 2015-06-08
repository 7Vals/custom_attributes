class <%= name %>CustomAttributeDefinition < ActiveRecord::Base
    include CustomAttributes::CustomAttributeDefinition
    scope :by_sort_order, -> { order('sort_order ASC') }
    <% if options.tenant %>
      validates_uniqueness_of :attr_name, message: " a custom attribute with this name already exisits."
    <% else %>
      validates_uniqueness_of :attr_name, scope: :<%= options.tenant %>_id, message: " a custom attribute with this name already exisits."
    <% end %>

    <% if options.tenant %>
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    # Uncomment the following if you want to define a default_scope instead
    # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
    <% end %>
    validates_uniqueness_of :attr_name, scope: :company_id, message: 'a custom field with this name already exists.'
    validates_format_of :attr_name, with: /^[a-zA-Z0-9\_\s]+$/, multiline: true, message: 'special characters are not allowed in the name.'
end