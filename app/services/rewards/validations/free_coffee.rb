class Rewards::Validations::FreeCoffee < Rewards::Validations::Base
  def pass?
    (user_birthday_month || accumulated_100_points_in_a_calendar_month) && no_previous_similar_redemption
  end

  private

  def user_birthday_month
    user.date_of_birth.mon == Date.today.mon
  end

  def accumulated_100_points_in_a_calendar_month
    user.points.where(created_at: Date.today.beginning_of_month..Date.today.end_of_month).sum(:points_earned).to_i >= 100
  end
end