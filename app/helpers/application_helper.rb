module ApplicationHelper

  #define the logo for all pages
  def logo
    logo=image_tag("logo.png",
                  :alt => "PalFlix", 
                  :width => '100px')
  end

  # Return a title on a per-page basis.
  def title
    base_title = "PalFlix"
    if @title.nil?
      base_title
    else
      "#{base_title} | #{@title}"
    end
  end
  
end
