class <%= name %>CustomAttributeDefinition < ActiveRecord::Base
  include CustomAttributes::CustomAttributeDefinition
  has_many :custom_attribute_options, dependent: :destroy, class_name: "<%= name %>CustomAttributeDefinition", foreign_key: "<%= singular_name %>_custom_attribute_definition_id"
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
  accepts_nested_attributes_for :custom_attribute_options, allow_destroy: :true
end