module ApplicationHelper
  def full_title page_title
    base_title = t "project_name"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def image_preview object
    image_tag object.image.exists? ? object.image.url : "sao.jpg",
      id: "image_preview", class: "img-responsive", size: "300x300"
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.send(association).klass.new
    id = new_object.object_id
    fields = f.fields_for(association, new_object, child_index: id) do |builder|
      render(association.to_s.singularize + "_fields", f: builder)
    end
    link_to name, "#", class: "add_fields btn btn-primary",
      data: {id: id, fields: fields.gsub("\n", "")}
  end

  def link_to_add_fields_search name, f, type
    new_object = f.object.send "build_#{type}"
    id = "new_#{type}"
    fields = f.send "#{type}_fields", new_object, child_index: id do |builder|
      render type.to_s + "_fields", f: builder
    end
    link_to name, "#", class: "add_fields btn btn-primary btn-xs",
      data: {id: id, fields: fields.gsub("\n", "")}
  end
end
