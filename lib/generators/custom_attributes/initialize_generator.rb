require 'rails/generators'

module CustomAttributes
  module Generators
    class InitializeGenerator < Rails::Generators::NamedBase
      include Rails::Generators::Migration

      source_root File.expand_path("../templates", __FILE__)
      class_option :tenant, default: false

      def self.next_migration_number(path)
        unless @prev_migration_nr
          @prev_migration_nr = Time.now.utc.strftime("%Y%m%d%H%M%S").to_i
        else
          @prev_migration_nr += 1
        end
        @prev_migration_nr.to_s
      end

      def views
        template "view.html.erb", "app/views/#{file_name}_custom_attribute_values/_#{file_name}_custom_attribute.html.erb"
      end

      def create_base_models
        template "custom_attribute_definition_model.rb", "app/models/#{file_name}_custom_attribute_definition.rb"
        template "custom_attribute_value_model.rb", "app/models/#{file_name}_custom_attribute_value.rb"
      end

      def create_derived_custom_attribute_values
        create_custom_attribute_value_sub_class("String")
        create_custom_attribute_value_sub_class("Integer")
      end

      def create_migrations
        migration_template "migration.rb", "db/migrate/create_custom_attributes_for_#{file_name}.rb"
      end

      def create_custom_attribute_concern
        template "custom_attributes_concern.rb", "app/models/concerns/#{file_name}_custom_attributes.rb"
      end

      def include_concern_in_model
        #TODO: Is this fool-proof?
        inject_into_file "app/models/#{file_name}.rb", after: "ActiveRecord::Base\n" do <<-BLOCK.gsub(/^ {4}/, '')
          include #{name}CustomAttributes
          BLOCK
        end
      end

      def sub_class
        @sub_class
      end

    private
      def create_custom_attribute_value_sub_class (sub_class)
        @sub_class = sub_class
        template "custom_attribute_value_sub_class_model.rb", "app/models/#{file_name}_custom_attribute_#{sub_class.underscore}_value.rb"
        template "custom_attribute_value_sub_class.html.erb", "app/views/#{file_name}_custom_attribute_#{sub_class.underscore}_values/_#{file_name}_custom_attribute_#{sub_class.underscore}_value.html.erb"
      end
    end
  end
end