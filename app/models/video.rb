class Video < ActiveRecord::Base
  def thumbnail
    return url
  end
end
