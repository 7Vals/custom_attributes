module CustomAttributes
  module CustomAttributeOption
    extend ActiveSupport::Concern
    included do
      validates :label, presence: { message: 'Option cannot be blank, either remove the blank option or add a value to it' }
      validates :label, format: { with: /\A[a-zA-Z\_\s0-9]+\z/, message: 'cannot contain special characters.' }, unless: -> { respond_to?(:linkable_resource_id) && linkable_resource_id.present? }
      default_scope -> { order(:position) }
    end
  end
end