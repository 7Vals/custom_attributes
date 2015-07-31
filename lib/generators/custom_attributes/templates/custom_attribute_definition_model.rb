class <%= name %>CustomAttributeDefinition < ActiveRecord::Base
    include CustomAttributes::CustomAttributeDefinition
<% if options.tenant %>
    validates :attr_name, uniqueness: { scope: :<%= options.tenant %>_id, message: " has already been taken." }
<% else %>
    validates :attr_name, uniqueness: true, message: " has already been taken."
<% end %>
<% if options.tenant %>
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    # Uncomment the following if you want to define a default_scope instead
    # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
<% end %>
end