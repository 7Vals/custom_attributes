class CreateCustomAttributesCustomAttributes < ActiveRecord::Migration
  def change
    create_table :custom_attributes_custom_attributes do |t|
      t.string :attr_name
      t.string :attr_type

      t.timestamps null: false
    end
  end
end
