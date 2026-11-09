require 'active_record'
require 'active_support/test_case'
require 'minitest/autorun'
require_relative '../../../app/models/custom_attributes/custom_attribute'
require_relative '../../../app/models/custom_attributes/custom_attribute_definition'

# The dummy app under test/dummy does not boot on Rails 6.1, so this test builds the one table it needs.
# Run it with: bundle exec ruby -Ilib -Itest test/models/custom_attributes/custom_attribute_definition_test.rb
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
ActiveRecord::Schema.verbose = false
ActiveRecord::Schema.define do
  create_table :widget_custom_attribute_definitions do |t|
    t.string  :attr_name
    t.string  :attr_type
    t.text    :default_value
    t.integer :sort_order
    t.boolean :hide_visibility_from_staff, default: false
  end
end

class WidgetCustomAttributeDefinition < ActiveRecord::Base
  include CustomAttributes::CustomAttributeDefinition
end

module CustomAttributes
  class CustomAttributeDefinitionTest < ActiveSupport::TestCase
    def definition(attributes = {})
      WidgetCustomAttributeDefinition.new({ attr_name: 'Serial number', attr_type: CustomAttribute::TYPE_TEXT }.merge(attributes))
    end

    def number_definition(default_value, type = CustomAttribute::TYPE_NUMBER)
      definition(attr_type: type, default_value: default_value)
    end

    test 'attr_name accepts letters, underscores and spaces' do
      ['Serial number', 'serial_number', 'A'].each do |name|
        assert definition(attr_name: name).valid?, "#{name.inspect} should be valid"
      end
    end

    test 'attr_name rejects other characters' do
      ['Serial#', 'Serial 2', '<b>Serial</b>', ''].each do |name|
        assert_not definition(attr_name: name).valid?, "#{name.inspect} should be invalid"
      end
    end

    test 'attr_name must not be nil or blank' do
      [nil, '', '   '].each do |name|
        assert_not definition(attr_name: name).valid?, "#{name.inspect} should be invalid"
      end
    end

    test 'attr_name is checked on every line, not only one of them' do
      ["Serial number\n<img src=x onerror=alert(1)>", "<script>alert(1)</script>\nSerial number", "Serial number\nSerial 2"].each do |name|
        assert_not definition(attr_name: name).valid?, "#{name.inspect} should be invalid"
      end
    end

    test 'default_value of a number attribute accepts numbers and blank' do
      ['5', '-1.5', '+2', '.5', '10.', ''].each do |value|
        assert number_definition(value).valid?, "#{value.inspect} should be valid"
      end
    end

    test 'default_value of a number attribute rejects text' do
      ['abc', '5x', '1.2.3'].each do |value|
        assert_not number_definition(value).valid?, "#{value.inspect} should be invalid"
      end
    end

    test 'default_value of a number attribute is checked on every line' do
      ["5\nabc", "abc\n5", "5\n", "\n5"].each do |value|
        assert_not number_definition(value).valid?, "#{value.inspect} should be invalid"
      end
    end

    test 'default_value of a decimal attribute is checked like a number' do
      ['1.5', '-0.25'].each do |value|
        assert number_definition(value, CustomAttribute::TYPE_DECIMAL).valid?, "#{value.inspect} should be valid"
      end
      ['1.5x', "1.5\nabc", "1.5\n"].each do |value|
        assert_not number_definition(value, CustomAttribute::TYPE_DECIMAL).valid?, "#{value.inspect} should be invalid"
      end
    end

    test 'default_value of a text attribute is not checked as a number' do
      assert definition(default_value: 'hello').valid?
    end
  end
end
