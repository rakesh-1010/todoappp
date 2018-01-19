FactoryBot.define do
  factory :task do
    id (1..999).to_a.sample
    description "Some Description"
    is_completed [true,false].sample
    user_id 1
  end
end
