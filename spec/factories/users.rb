FactoryBot.define do

  factory :user do
    currency   { 'USD' }
    date_of_birth   { Date.today }
    created_at      { Date.today - 1.week }
    after :create do |user|
      create_list :user_client_transaction, 15, user: user
      create_list :points_log, 30, points_earned: 1000, user: user
    end


    trait :standard_tier_user do
      email           { Faker::Internet.email }
      full_name       { Faker::Name.name }
      loyalty_tier    { 'standard' }
    end

    trait :gold_tier_user do
      email           { Faker::Internet.email }
      full_name       { Faker::Name.name }
      loyalty_tier { 'gold' }
    end

    trait :platinum_tier_user do
      email           { Faker::Internet.email }
      full_name       { Faker::Name.name }
      loyalty_tier { 'platinum' }
    end
  end
end