FactoryBot.define do

  factory :user_client_transaction, class: UserClientTransaction do
    currency  { 'USD' }
    amount    { 500 }
    created_at { Date.today - 63.days}
    client
  end
end
