class CreateModuleLinkageFor<%= name %>CustomAttributes < ActiveRecord::Migration[6.1]
  def change
    create_table :<%= singular_table_name %>_custom_attribute_linked_modules do |t|
      t.string      :module_name
      t.text        :filters
      t.bigint      :company_id, index: true, null: false
      t.integer     :<%= singular_table_name %>_custom_attribute_definition_id, null: false

      t.timestamps null: false
      t.index %i[company_id <%= singular_table_name %>_custom_attribute_definition_id], name: :index_<%= singular_table_name %>_custom_attribute_linked_modules
    end

    change_table :<%= singular_table_name %>_custom_attribute_definitions, bulk: true do |t|
      t.boolean :linked_to_module, default: false, null: false
      t.string :module_linkage_category
      t.index %i[company_id linked_to_module module_linkage_category], name: :index_<%= singular_table_name %>_custom_attribute_on_module_linkage_columns
    end

    change_table :<%= singular_table_name %>_custom_attribute_options do |t|
      t.belongs_to :linkable_resource, polymorphic: true, index: { name: :index_<%= singular_table_name %>_custom_attribute_options_on_linkable_resource }
    end

    change_table :<%= singular_table_name %>_custom_attribute_values do |t|
      t.belongs_to :linkable_resource, polymorphic: true, index: { name: :index_<%= singular_table_name %>_custom_attribute_values_on_linkable_resource }
    end
  end
end
