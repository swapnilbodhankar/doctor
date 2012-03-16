module PatientsHelper
   def link_to_add(name, association)
      @fields ||= {}
      @template.after_nested_form do
        model_object = object.class.reflect_on_association(association).klass.new
        output = %Q[<div id="#{association}_fields_blueprint" style="display: none">].html_safe
        output << fields_for(association, model_object, 
                  :child_index => "new_#{association}", 
                  &@fields[association])
        output.safe_concat('</div>')
        output
      end
      @template.link_to(name, "javascript:void(0)", 
                        :class => "add_nested_fields", 
                        "data-association" => association)
    end

end
