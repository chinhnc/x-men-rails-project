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
end
