class CreateCustomAttributesFor<%= name %> < ActiveRecord::Migration

  def change
    create_table (:<%= singular_table_name %>_custom_attribute_definitions) do |t|
      t.string :attr_name
      t.string :attr_type
      t.integer :sort_order
  <% if options.tenant %>
      t.integer :<%= options.tenant.underscore %>_id, foreign_key: true
  <% end %>
      t.timestamps null: false
    end

    create_table (:<%= singular_table_name %>_custom_attribute_values) do |t|
      t.string :type
      t.string :string_value
      t.integer :integer_value
      t.references :<%= singular_table_name %>, foreign_key: true
      t.references :<%= singular_table_name %>_custom_attribute_definition, foreign_key: true
  <% if options.tenant %>
      t.integer :<%= options.tenant.underscore %>_id, foreign_key: true
  <% end %>
      t.timestamps null: false
    end

    #TODO: Add index for tenant
    add_index  :<%= singular_table_name %>_custom_attribute_values, :<%= singular_table_name %>_custom_attribute_definition_id, name: 'index_<%= singular_table_name %>_cattr_vals_on_cattr_defn'

  end
end
