module CustomAttributes
  module CustomAttributeDefinition
    extend ActiveSupport::Concern
    included do
    
      scope :by_sort_order, -> { order('sort_order ASC') }
      validates :attr_name, format: { with: /^[a-zA-Z\_\s]+$/, multiline: true, message: 'cannot contain special characters.' }

    end
  end
end