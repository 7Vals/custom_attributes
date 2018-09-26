class CreateCustomAttributesFor<%= name %> < ActiveRecord::Migration

  def change
    create_table (:<%= singular_table_name %>_custom_attribute_definitions) do |t|
      t.string :attr_name
      t.string :attr_type
      t.text   :default_value
      t.string :placeholder
      t.integer :sort_order
      t.boolean :required, default: false
    end
  <% if options.tenant %>
      t.integer :<%= options.tenant.underscore %>_id, foreign_key: true
  <% end %>
      t.timestamps null: false
    end

  <% if options.tenant %>
    add_foreign_key :<%= singular_table_name %>_custom_attribute_definitions, :<%= options.tenant.pluralize %>, column: :<%= options.tenant.underscore %>_id, on_delete: :cascade
  <% end %>

    create_table (:<%= singular_table_name %>_custom_attribute_values) do |t|
      t.string    :type
      t.text      :string_value
      t.integer   :integer_value
      t.boolean   :boolean_value
      t.decimal   :double_value, precision: 54, scale: 9
      t.datetime  :date_time_value
      t.references :<%= singular_table_name %>, foreign_key: true
      t.references :<%= singular_table_name %>_custom_attribute_definition, foreign_key: true
  <% if options.tenant %>
      t.integer :<%= options.tenant.underscore %>_id, foreign_key: true
  <% end %>
      t.timestamps null: false
    end

    add_foreign_key :<%= singular_table_name %>_custom_attribute_values, :<%= singular_table_name %>_custom_attribute_definitions, on_delete: :cascade
  <% if options.tenant %>
    add_foreign_key :<%= singular_table_name %>_custom_attribute_values, :<%= options.tenant.pluralize %>, column: :<%= options.tenant.underscore %>_id, on_delete: :cascade
  <% end %>

    create_table (:<%= singular_table_name %>_custom_attribute_options) do |t|
      t.text :label
      t.integer :position
      t.references :<%= singular_table_name %>_custom_attribute_definition, foreign_key: true, index: true

      <% if options.tenant %>
        t.integer :<%= options.tenant.underscore %>_id, foreign_key: true, index: true
      <% end %>

      t.timestamps null: false
    end

    add_foreign_key :<%= singular_table_name %>_custom_attribute_options, :<%= singular_table_name %>_custom_attribute_definitions, on_delete: :cascade
    <% if options.tenant %>
      add_foreign_key :<%= singular_table_name %>_custom_attribute_options, :<%= options.tenant.pluralize %>, column: :<%= options.tenant.underscore %>_id, on_delete: :cascade
    <% end %>

    create_table (:<%= singular_table_name %>_custom_attribute_value_datas) do |t|
      t.references :<%= singular_table_name %>_custom_attribute_option, foreign_key: true, index: true
      t.references :<%= singular_table_name %>_custom_attribute_value, foreign_key: true, index: true

      <% if options.tenant %>
        t.integer :<%= options.tenant.underscore %>_id, foreign_key: true, index: true
      <% end %>

      t.timestamps null: false
    end

    add_foreign_key :<%= singular_table_name %>_custom_attribute_value_datas, :<%= singular_table_name %>_custom_attribute_options, on_delete: :cascade
    add_foreign_key :<%= singular_table_name %>_custom_attribute_value_datas, :<%= singular_table_name %>_custom_attribute_values, on_delete: :cascade
    <% if options.tenant %>
      add_foreign_key :<%= singular_table_name %>_custom_attribute_value_datas, :<%= options.tenant.pluralize %>, column: :<%= options.tenant.underscore %>_id, on_delete: :cascade
    <% end %>

  end
end
