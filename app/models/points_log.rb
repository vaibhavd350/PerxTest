class PointsLog < ApplicationRecord
  belongs_to :user
  after_save :update_user_tier

  private

  def update_user_tier
    ::UserTierUpdateService.new(self.points_earned, self.user).update_tier
  end
end
