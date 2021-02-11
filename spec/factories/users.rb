FactoryBot.define do
  factory :user do

    name { Faker::DcComics.unique.hero.gsub(/\s+/, "") }
    email { Faker::Internet.unique.email }
    password { SecureRandom.base64(20) }
    provider { 'twitch' }
    description { Faker::Lorem.sentence }

    trait :admin do
      admin { true }
    end
    
  end
end
