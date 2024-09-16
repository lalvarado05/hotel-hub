FactoryBot.define do
  factory :user do
    first_name { "Test" }
    last_name  { "PleaseWork" }
    sequence(:email) { |n| "user#{n}@example.com" }
    sequence(:phone_number) { |n| "1234567#{n % 10}" }
    password { "password123" }
    role { "admin" }
  end
end