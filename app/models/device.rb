class Device < ActiveRecord::Base

  before_save :cleanse_device, :auto_generate_name

  belongs_to :user

  scope :active, -> { where(active: true) }
  scope :inactive, -> { where(active: false) }

  validates :device_id, length: { is: 24 }, unless: -> { device_id.blank? }

  def shuffle_name
    self.name = generated_name
    self.save
  end

  private

  def cleanse_device
    if self.device_id.blank?
      self.device_id = nil
      self.active = false
    end
  end

  def auto_generate_name
    self.name ||= generated_name
  end

  def generated_name
    Faker::Adjective.positive.titlecase.strip.gsub(/\s+/, "")
                    .concat Faker::Color.color_name.titlecase.strip.gsub(/\s+/, "")
                                        .concat [Faker::Food.fruits, Faker::Food.vegetables, Faker::Food.spice]
                                                  .sample.to_s.titlecase.strip.gsub(/\s+/, "")
  end

end
