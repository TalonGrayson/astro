class Tag < ActiveRecord::Base

  has_one_attached :tag_image

  scope :active, -> { where(deleted: false) }
  scope :astrodial, -> { where(origin: 'AstroDial') }
  scope :amiibo, -> { where(origin: 'Amiibo') }

end
