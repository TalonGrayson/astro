class Tag < ActiveRecord::Base

  before_save :hex_to_rgb

  has_one_attached :tag_image

  scope :active, -> { where(deleted: false) }
  scope :astrodial, -> { where(origin: 'AstroDial') }
  scope :amiibo, -> { where(origin: 'Amiibo') }

  def hex_to_rgb
    if self.light_rgb.match(/#[a-f,0-9]*/)
      self.light_rgb = self.light_rgb.paint.to_rgb[4..-2].gsub(' ', '')
    end
  end

end
