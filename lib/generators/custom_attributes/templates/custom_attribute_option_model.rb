class <%= name %>CustomAttributeOption < ActiveRecord::Base
  include CustomAttributes::CustomAttributeOption
  belongs_to :custom_attribute_defn, class_name: "<%= name %>CustomAttributeDefinition", foreign_key: "<%= singular_name %>_custom_attribute_definition_id"
  has_many :custom_attribute_option_values, dependent: :destroy, class_name: "<%= name %>CustomAttributeOptionValue", foreign_key: "<%= singular_name %>_custom_attribute_option_id"
  validates :label, uniqueness: { scope: :<%= singular_name %>_custom_attribute_definition_id }
  <% if options.tenant %>
    belongs_to :<%= options.tenant %>_id
  <% end %>
end