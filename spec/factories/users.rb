FactoryBot.define do
  factory :user do
    id (1..999).to_a.sample
    name Faker::Name.name
    email Faker::Internet.email
    password 123456 
  end
end
