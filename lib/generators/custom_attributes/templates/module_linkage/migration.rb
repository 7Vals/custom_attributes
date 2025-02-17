class CreateModuleLinkageFor<%= name %>CustomAttributes < ActiveRecord::Migration[6.1]
  def change
    change_table :<%= singular_table_name %>_custom_attribute_definitions, bulk: true do |t|
      t.boolean :linked_to_module, default: false, null: false
      t.string :module_linkage_category
      t.index %i[company_id linked_to_module module_linkage_category], name: :index_<%= singular_table_name %>_custom_attribute_on_module_linkage_columns
    end

    change_table :<%= singular_table_name %>_custom_attribute_options do |t|
      t.belongs_to :linkable_resource, polymorphic: true
      t.index %i[company_id linkable_resource_type linkable_resource_id], name: :index_<%= singular_table_name %>_custom_attribute_options_on_linkable_resource
    end

    change_table :<%= singular_table_name %>_custom_attribute_values do |t|
      t.belongs_to :linkable_resource, polymorphic: true
      t.index %i[company_id linkable_resource_type linkable_resource_id], name: :index_<%= singular_table_name %>_custom_attribute_values_on_linkable_resource
    end
  end
end
