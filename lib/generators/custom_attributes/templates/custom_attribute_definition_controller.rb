class <%= name %>CustomAttributeDefinitionsController < CustomAttributes::CustomAttributeDefinitionsController
  <% if options.tenant %>
  def custom_attributes_scope
    <%= name %>CustomAttributeDefinition.current_tenant @current_company
  end
  # You can delete the remove the above scope if you have defined a default_scope for <%= name %>CustomAttributeDefinition.
  <% end %>

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
      if @custom_attribute.save
        format.html { redirect_to action: :index }
        format.json { render :show, status: :created, location: @custom_attribute }
      else
        format.html { render :new }
        format.json { render json: @custom_attribute.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def custom_attribute_params
    params.require(:<%= singular_name %>_custom_attribute_definition).permit(:attr_name, :attr_type, :sort_order)
  end

end