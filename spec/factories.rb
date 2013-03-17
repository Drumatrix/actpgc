FactoryGirl.define do
  factory :user do
    name "John Smith"
    email "John.Smith@test.com"
    password "foobar"
    password_confirmation "foobar"
  end
end
