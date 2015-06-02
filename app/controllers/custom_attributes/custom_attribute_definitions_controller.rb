module CustomAttributes
  class CustomAttributeDefinitionsController < ApplicationController

    def index
      @custom_attributes = custom_attributes_scope.all
    end

    def new
      @custom_attribute = custom_attributes_scope.new
    end

  end
end