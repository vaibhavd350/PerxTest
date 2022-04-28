FactoryBot.define do

  factory :reward do

    trait :reward_one do
      name {'Free Coffee'}
      reward_type {'birthday'}
    end
    

    trait :reward_two do
      name {'Free Coffee'}
      reward_type {'points'}
    end

    trait :reward_three do
      name {'Cash Rebate'}
      reward_type {'points'}
    end

    trait :reward_four do
      name {'Movie Ticket'}
      reward_type {'points'}
    end
  end

end
