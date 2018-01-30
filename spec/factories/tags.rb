FactoryBot.define do
  factory :tag do
    user_id 1
    task_id (1..999).to_a.sample
  end
end
