module CustomAttributes
  class CustomAttributeDefinitionsController < ApplicationController

    def index
      @custom_attributes = custom_attributes_scope.all
    end

    def new
      @custom_attribute = custom_attributes_scope.new
      2.times { @custom_attribute.custom_attribute_options.build }
      @custom_attribute.sort_order = custom_attributes_scope.size() + 1
    end

  end
end