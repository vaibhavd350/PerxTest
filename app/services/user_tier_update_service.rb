class UserTierUpdateService

  attr_reader :points
  attr_accessor :user

  def initialize(points, user)
    @points = points
    @user = user
  end

  def update_tier
    user.update(loyalty_tier: current_loyalty_tier) if user.loyalty_tier != current_loyalty_tier
  end

  private

  def current_loyalty_tier
    if points < 1000
      'standard'
    elsif points >= 1000 && points < 5000
      'gold'
    elsif points >= 5000
      'platinum'
    end
  end
end