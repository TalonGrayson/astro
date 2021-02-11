class Tag < ActiveRecord::Base
  require 'color_converter'

  before_create :roll_stats, :init
  before_save :generate_random_data, :clean_light_rgb, :clean_user_id

  has_one_attached :tag_image

  belongs_to :user

  scope :active, -> { where(deleted: false) }

  def roll_stats
    stats = [:health, :defence, :attack, :speed]
    max   = 25

    stats.size.times do
      rolling_for = stats.delete(stats.sample)

      roll_max = max > 10 ? 10 : max
      roll     = Faker::Number.between(from: 1, to: roll_max)
      max      -= roll

      if rolling_for == :health
        self.health = roll
      elsif rolling_for == :defence
        self.defence = roll
      elsif rolling_for == :attack
        self.attack = roll
      elsif rolling_for == :speed
        self.speed = roll
      end
    end
  end

  def hex_to_rgb_array
    if self.light_rgb.match(/#[a-f,0-9]*/)
      self.light_rgb = ColorConverter.rgb(self.light_rgb)
    end
  end

  def light_rgb_as_string
    if self.light_rgb.match(/#[a-f,0-9]*/)
      rgb_array = ColorConverter.rgb(self.light_rgb)
      self.light_rgb = "#{rgb_array[0]},#{rgb_array[1]},#{rgb_array[2]}"
    elsif self.light_rgb.class == Array
      self.light_rgb = "#{self.light_rgb[0]},#{self.light_rgb[1]},#{self.light_rgb[2]}"
    end
  end

  def light_rgb_as_array
    if self.light_rgb.match(/#[a-f,0-9]*/)
      self.light_rgb = ColorConverter.rgb(self.light_rgb)
    elsif self.light_rgb.class == String
      [
        self.light_rgb.split(',')[0].to_i,
        self.light_rgb.split(',')[1].to_i,
        self.light_rgb.split(',')[2].to_i
      ]
    end
  end

  private

  def clean_light_rgb
    light_rgb_as_string
  end

  def init
    self.deleted   ||= false
    self.last_seen ||= DateTime.now
  end

  def clean_user_id
    if self.user_id < 1
      self.user_id = nil
    end
  end

  def generate_random_data
    self.origin    ||= Faker::Color.color_name
    self.variety   ||= Faker::Color.color_name
    self.name      ||= Faker::Color.color_name
    self.light_rgb ||= Faker::Color.single_rgb_color.to_s + "," + Faker::Color.single_rgb_color.to_s + "," + Faker::Color.single_rgb_color.to_s
  end

end
