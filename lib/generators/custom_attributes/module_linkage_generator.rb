require 'rails/generators'

module CustomAttributes
  module Generators
    class ModuleLinkageGenerator < Rails::Generators::NamedBase
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

      def create_migrations
        migration_template "module_linkage/migration.rb", "db/migrate/create_module_linkage_for_#{file_name}_custom_attributes.rb"
      end
    end
  end
end
