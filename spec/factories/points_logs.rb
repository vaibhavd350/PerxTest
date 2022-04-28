FactoryBot.define do

  factory :points_log, class: PointsLog do
    created_at  { Date.today + 1.week }
    valid_until { Date.today + 1.year }
    association :issued_by, factory: :client
  end
end
