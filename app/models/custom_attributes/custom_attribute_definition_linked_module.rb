# frozen_string_literal: true

# All custom attribute resources should have One-to-One relation with this object
# Used to defined linked module settings
module CustomAttributes
  class CustomAttributeDefinitionLinkedModule < ApplicationRecord
    def self.linkable_resource_display_value(*_argz)
      raise NotImplementedError
    end
  end
end
