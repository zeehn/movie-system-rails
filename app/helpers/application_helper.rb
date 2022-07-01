module ApplicationHelper
  def main_image(movie)
    if movie.main_image.attached? 
      image_tag movie.main_image
    else
      image_tag("placeholder.png")
    end
  end
end
