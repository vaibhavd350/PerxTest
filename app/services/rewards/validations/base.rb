class Rewards::Validations::Base

  attr_reader :user, :params

  def initialize(user, params)
    @user = user
    @params = params
  end

  def no_previous_similar_redemption
    Reward.where(user_id: user.id, name: params[:name], reward_type: params[:reward_type]).empty?
  end
end