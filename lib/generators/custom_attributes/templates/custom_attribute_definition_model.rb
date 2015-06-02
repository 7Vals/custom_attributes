class <%= name %>CustomAttributeDefinition < ActiveRecord::Base
    scope :by_sort_order, -> { order('sort_order ASC') }
    <% if options.tenant %>
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    # Uncomment the following if you want to define a default_scope instead
    # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
    <% end %>
end