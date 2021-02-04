# frozen_string_literal: true

FactoryBot.define do
  factory :tag do

    tag_hex { SecureRandom.uuid }
    origin { Faker::Coffee.origin.strip }
    variety { Faker::Coffee.variety.strip }
    name { Faker::Coffee.blend_name.strip }
    light_rgb do
      "#{Faker::Color.rgb_color[0]},#{Faker::Color.rgb_color[1]},#{Faker::Color.rgb_color[2]}"
    end
    health { Faker::Number.between(from: 1, to: 10)}
    defence { Faker::Number.between(from: 1, to: 10)}
    attack { Faker::Number.between(from: 1, to: 10)}
    speed { Faker::Number.between(from: 1, to: 10)}
    last_seen { DateTime.now - (Faker::Number.between(from: 5, to: 5_000)) }
    deleted { false }

    user

    trait :deleted do
      deleted { true }
    end

    trait :upgraded do
      health { Faker::Number.between(from: 11, to: 100)}
      defence { Faker::Number.between(from: 11, to: 100)}
      attack { Faker::Number.between(from: 11, to: 100)}
      speed { Faker::Number.between(from: 11, to: 100)}
    end

    trait :with_image do
      tag_image { Rack::Test::UploadedFile.new('spec/fixtures/files/hunk.jpg', 'image/jpg') }
    end

  end
end
