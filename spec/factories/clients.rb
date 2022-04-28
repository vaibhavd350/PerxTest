FactoryBot.define do

  factory :client do
    email            { 'client@email.com' }
    name             { 'IBM'  }
    business_type    { 'IT' }
  end
end