module CustomAttributes
  class CustomAttributeDefinitionsController < ApplicationController

    def index
      @custom_attributes = custom_attributes_scope.all
    end

    def new
      @custom_attribute = custom_attributes_scope.new
      @custom_attribute.sort_order = custom_attributes_scope.size() + 1
    end

  end
end