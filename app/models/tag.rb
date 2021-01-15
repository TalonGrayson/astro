class Tag < ActiveRecord::Base

  before_save :hex_to_rgb, :clean_user_id

  has_one_attached :tag_image

  belongs_to :user

  scope :active, -> { where(deleted: false) }

  def hex_to_rgb
    if self.light_rgb.match(/#[a-f,0-9]*/)
      self.light_rgb = self.light_rgb.paint.to_rgb[4..-2].gsub(' ', '')
    end
  end

  def clean_user_id
    if self.user_id < 1
      self.user_id = nil
    end
  end

end
