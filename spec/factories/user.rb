FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "test_user_#{n}@example.com" }
    sequence(:username) { |n| "test_user_#{n}" }
    password "password"
    password_confirmation "password"
    admin false
  end
end
