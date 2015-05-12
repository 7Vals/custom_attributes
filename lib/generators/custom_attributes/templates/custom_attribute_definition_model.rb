class <%= name %>CustomAttributeDefinition < ActiveRecord::Base
    scope :by_sort_order, -> { order('sort_order ASC') }
    <% if options.tenant %>
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    <% end %>
end