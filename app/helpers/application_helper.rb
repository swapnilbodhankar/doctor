module ApplicationHelper


def partial_button(f, attribute, link_name)
  returning "" do |out|
    base      = f.object.class.to_s.underscore
    singular  = attribute.to_s.underscore
    plural    = singular.pluralize
    id        = "add_nested_partial_#{base}_#{singular}"
    f.fields_for attribute.to_s.classify.constantize.new do |fq|
      html = render(:partial => singular, :locals => { :f => fq})
      js   = %|new NestedFormPartial("#{escape_javascript(html)}", { parent:"#{base}", singular:"#{singular}", plural:"#{plural}"}).insertHtml();|
      out << hidden_field_tag(nil, js, :id => "js_#{id}") + "\n"
      out << content_tag(:input, nil, :type => "button", :value => link_name, :class => "add_nested_partial", :id => id)
    end
  end
end


end
