class <%= name %>CustomAttributeDefinitionsController < CustomAttributes::CustomAttributeDefinitionsController
  def new
    super
    respond_to do |format|
      format.js
    end
  end

  #TODO: Move this to the parent controller
  def create
<% if options.tenant %>
    @custom_attribute = custom_attributes_scope.new(custom_attribute_params)
<% end %>
    respond_to do |format|
      if @custom_attribute.save_custom_attribute(params[:selected_option_label])
        format.html { redirect_to action: :index }
        format.json { render :show, status: :created, location: @custom_attribute }
      else
        format.html { render :new }
        format.json { render json: @custom_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  <% if options.tenant %>
  def custom_attributes_scope
    <%= name %>CustomAttributeDefinition.current_tenant @current_company
  end
  # You can delete the remove the above scope if you have defined a default_scope for <%= name %>CustomAttributeDefinition.
  <% end %>
  def custom_attribute_params
    list_params_allowed = [:attr_name, :attr_type, :sort_order, :hide_visibility_from_staff]
    if singular_name == 'vendor'
      list_params_allowed += [:send_email_alert, :scheduled_alert, :is_recurring, :repeat_cycle, :repeat_duration, :advance_alert, :advance_alert_days, :subsequent_alert, :subsequent_alert_days]
    end
    params.require(:<%= singular_name %>_custom_attribute_definition).permit(
      list_params_allowed,
      custom_attribute_options_attributes: [
        :id,
        :label,
        :position,
        :_destroy
      ]
    )
  end

end