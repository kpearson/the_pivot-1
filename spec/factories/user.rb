FactoryGirl.define do
  factory :user do
    email "paullorijgu@gmail.com"
    full_name  "Laul Guberson"
    display_name "jgu"
    password "gu"
    role "default"
    provider "twitter"
    uid "abc123"
  end

  factory :admin, class: User do
    email "admin@gmail.com"
    full_name  "Admin man"
    display_name "jgu"
    password "admin"
    role "admin"
    provider "twitter"
    uid "abc123"
  end
end
