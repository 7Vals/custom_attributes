class CreateCustomAttributesFor<%= name %> < ActiveRecord::Migration

  def change
    create_table (:<%= singular_table_name %>_custom_attribute_definitions) do |t|
      t.string :attr_name
      t.string :attr_type
      t.text   :default_value
      t.string :placeholder
      t.integer :sort_order
      t.boolean :required, default: false
      t.boolean :hide_visibility_from_staff, default: false
      t.boolean :send_email_alert, default: false
      t.boolean :scheduled_alert, default: false
      t.boolean :is_recurring, default: false
      t.integer :repeat_duration, default: 1
      t.text,   :repeat_cycle, default: 'Day'
      t.boolean :advance_alert, default: false
      t.integer :advance_alert_days, default: 1
      t.boolean :subsequent_alert, default: false
      t.integer :subsequent_alert_days, default: 1
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
      t.date       :recurring_date_value
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
      t.text :label, index: { length: 767 }
      t.integer :position, index: true
      t.references :<%= singular_table_name %>_custom_attribute_definition, index: true

      <% if options.tenant %>
        t.integer :<%= options.tenant.underscore %>_id, index: true
      <% end %>

      t.timestamps null: false
    end

    create_table (:<%= singular_table_name %>_custom_attribute_option_values) do |t|
      t.references :<%= singular_table_name %>_custom_attribute_option, index: true
      t.references :<%= singular_table_name %>_custom_attribute_value, index: true

      <% if options.tenant %>
        t.integer :<%= options.tenant.underscore %>_id, index: true
      <% end %>

      t.timestamps null: false
    end
  end
end
