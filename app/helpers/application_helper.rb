module ApplicationHelper
  def main_image(movie)
    if movie.main_image.attached? 
      image_tag movie.main_image.variant(resize_to_limit: [150, nil])
    else
      image_tag("placeholder.png")
    end
  end
end
