module <%= name %>CustomAttributes
  extend ActiveSupport::Concern
  # TODO: Move most of this file to a common parent

  included do
    has_many :custom_attribute_values, :class_name=>'<%= name %>CustomAttributeValue', autosave: true
    after_initialize :add_custom_attributes_with_default_values
  end

  def add_custom_attributes_with_default_values
    return unless self.new_record?
    return if self.custom_attributes.blank?
    self.custom_attributes.each do |cav|
      if cav.custom_attribute_defn.default_value.present? && cav.value.blank?
        cav.apply_default_value
        self.custom_attribute_values.push(cav)
      end
    end
  end

  def custom_attributes=(map_of_custom_attributes)
    return if map_of_custom_attributes.nil?

    map_of_custom_attributes.each do |key, value|
      custom_attribute_value = custom_attribute_values.find { |cav| cav.name==key }
      if not custom_attribute_value
  <% if options.tenant %>
        custom_attribute_defns  = <%= name %>CustomAttributeDefinition.all.current_tenant(<%= options.tenant %>_id)
        # Uncomment the following if you have defined a default_scope for <%= name %>CustomAttributeDefinition
        # custom_attribute_defns = <%= name %>CustomAttributeDefinition.all
  <% else %>
        custom_attribute_defns  = <%= name %>CustomAttributeDefinition.all
  <% end %>
        custom_attribute_defn   = custom_attribute_defns.find { |cad| cad.attr_name == key }
        custom_attribute_value  = <%= name %>CustomAttributeValue.initialize(custom_attribute_defn, self)
        self.custom_attribute_values.push(custom_attribute_value)
      end
      custom_attribute_value.value = value
    end
  end

  def custom_attributes
  <% if options.tenant %>
    custom_attribute_defns = <%= name %>CustomAttributeDefinition.all.current_tenant(<%= options.tenant %>_id)
    custom_attribute_defns.collect { |defn|
      custom_attribute_values.current_tenant(<%= options.tenant %>_id).find { |cv| cv.custom_attribute_defn==defn } || <%= name %>CustomAttributeValue.initialize(defn, self)
    }
  <% else %>
    custom_attribute_defns = <%= name %>CustomAttributeDefinition.all
    custom_attribute_defns.collect { |defn|
      custom_attribute_values.find { |cv| cv.custom_attribute_defn==defn } || <%= name %>CustomAttributeValue.initialize(defn, self)
    }
  <% end %>
  end

end