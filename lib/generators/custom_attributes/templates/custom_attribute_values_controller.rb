class <%= name %>CustomAttributeValuesController < CustomAttributes::CustomAttributeValuesController
  before_action :load_<%= singular_name %>_for_custom_attributes_values

private
  def load_<%= singular_name %>_for_custom_attributes_values
    @owner = <%= name %>.find(params['owner_id'])
  end

end