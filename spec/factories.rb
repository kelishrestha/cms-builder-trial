# frozen_string_literal: true

FactoryGirl.define do
  factory :api_key do
    app_info { { app_name: 'rails_template' } }
    access_token '1ic3Xb1K84uifO82CL5F'
  end

  factory :user do
    name 'Admin'
  end
end
