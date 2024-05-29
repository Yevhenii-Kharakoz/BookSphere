module ApplicationHelper
  def image_tag_ignore_case(image_name, options = {})
    images_dir = Rails.root.join('app', 'assets', 'images')
    image_path = Dir.glob(images_dir.join("**", image_name), File::FNM_CASEFOLD).first
    if image_path
      relative_path = Pathname.new(image_path).relative_path_from(images_dir).to_s
      image_tag(relative_path, options)
    else

      image_tag('placeholder.jpg', options)
    end
  end
end
