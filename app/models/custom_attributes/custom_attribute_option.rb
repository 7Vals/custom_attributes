module CustomAttributes
  module CustomAttributeOption
    extend ActiveSupport::Concern
    included do
      validates :label, presence: { message: 'Option cannot be blank, either remove the blank option or add a value to it' }
      validates :label, format: { with: /\A[a-zA-Z\_\s0-9]+\z/, message: 'cannot contain special characters.' }, if: -> { linkable_resource_id.blank? }
      default_scope -> { order(:position) }
      belongs_to :linkable_resource, polymorphic: true
    end

    def option
      linkable_resource_id.blank? ? read_attribute(:option) : linkable_resource_display_value
    end

    def linkable_resource_display_value
      CustomAttributeDefinitionLinkedModule.linkable_resource_display_value(linkable_resource)
    end
  end
end