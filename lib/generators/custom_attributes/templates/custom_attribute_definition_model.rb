class <%= name %>CustomAttributeDefinition < ActiveRecord::Base
  include CustomAttributes::CustomAttributeDefinition
  has_many :custom_attribute_options, dependent: :destroy, class_name: "<%= name %>CustomAttributeOption", foreign_key: "<%= singular_name %>_custom_attribute_definition_id"
  <% if options.tenant %>
    validates :attr_name, uniqueness: { scope: :<%= options.tenant %>_id, message: " has already been taken." }
  <% else %>
    validates :attr_name, uniqueness: true, message: " has already been taken."
  <% end %>
  <% if options.tenant %>
    scope :current_tenant, -> <%= options.tenant %>_id { where(<%= options.tenant %>_id: <%= options.tenant %>_id) }
    # Uncomment the following if you want to define a default_scope instead
    # default_scope { where(<%= options.tenant %>_id: Tenant.current_tenant) }
  <% end %>
  accepts_nested_attributes_for :custom_attribute_options, allow_destroy: :true

  def save_custom_attribute_definition(selected_option_label)
    begin
      transaction do
        save!
        if dropdown_type?
          selected_option = custom_attribute_options.find_by label: selected_option_label
          update! default_value: selected_option.try(:id)
        end
      end
    rescue ActiveRecord::ActiveRecordError => e
      e.errors.each { |error| self.errors.add(:base, error) }
      false
    end
  end

  def update_custom_attribute_definition(custom_attribute_params, selected_option_label)
    begin
      transaction do
        update!(custom_attribute_params)
        if dropdown_type?
          selected_option = custom_attribute_options.find_by label: selected_option_label
          update! default_value: selected_option.try(:id)
        end
      end
    rescue ActiveRecord::ActiveRecordError => e
      e.errors.each { |error| self.errors.add(:base, error) }
      false
    end
  end

  def selected_option
    custom_attribute_options.find_by(id: default_value).try(:label)
  end
end