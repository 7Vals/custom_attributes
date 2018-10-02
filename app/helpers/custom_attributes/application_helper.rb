module CustomAttributes::ApplicationHelper

  def link_to_add_options(name, f, association, options = {})
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = f.fields_for(association, new_object, child_index: "new_#{association}") do |builder|
      render("#{association.to_s.singularize}_fields", f: builder)
    end
    link_to_function(name, "add_option_to_dropdown_field('#{association}', '#{escape_javascript(fields)}')", options)
  end
end