class CreateCustomAttributesCustomAttributeValues < ActiveRecord::Migration
  def change
    create_table :custom_attributes_custom_attribute_values do |t|
      t.string :type
      t.string :owner_type
      t.integer :owner_id
      t.string :string_value
      t.integer :integer_value
      t.references :custom_attributes_custom_attribute, foreign_key: true

      t.timestamps null: false
    end

#TODO: add index for the custom_attribute_id column
#    add_index ()

  end
end
