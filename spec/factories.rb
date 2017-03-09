# frozen_string_literal: true
FactoryGirl.define do
  factory :link do
    url_input 'MyString'
    user_id 1
  end

  factory :user do
    username 'Kolapo'
    email 'danijuyusuf@andela.com'
    password '12345678'
    password_confirmation '12345678'
  end
end
