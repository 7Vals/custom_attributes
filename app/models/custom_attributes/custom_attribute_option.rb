module CustomAttributes
  module CustomAttributeOption
    extend ActiveSupport::Concern
    included do
      validates :label, presence: { message: 'Option cannot be blank, either remove the blank option or add a value to it' }
      default_scope -> { order(:position) }
    end

    # Deprecating this method as per RM# 54455, no longer needed
    def skip_format_validation?
      respond_to?(:linkable_resource_id) && linkable_resource_id.present?
    end
  end
end