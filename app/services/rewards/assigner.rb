class Rewards::Assigner
  include ActiveModel::Model

  attr_accessor :user, :errors, :reward
  attr_reader :params

  validate :free_coffee_conditions, if: -> {params[:name] == 'Free Coffee'}
  validate :cash_rebate_conditions, if: -> {params[:name] == 'Cash Rebate'}
  validate :movie_ticket_conditions, if: -> {params[:name] == 'Movie Ticket'}

  def initialize(user, params)
    @user = user
    @params = params
    @errors = ActiveModel::Errors.new(self)
    @reward = nil
  end

  def run
    if valid?
      assign_reward
    end
    errors.empty?
  rescue => e
    errors.add(:base, e.message)
    errors.empty?
  end

  private

  def assign_reward
    @reward = Reward.create!(user_id: user.id, name: params[:name], reward_type: params[:reward_type])
  end

  def free_coffee_conditions
    errors.add(:base, 'You can not claim free coffee') unless Rewards::Validations::FreeCoffee.new(user, params).pass?
  end

  def cash_rebate_conditions
    errors.add(:base, 'You can not claim cash rebate') unless Rewards::Validations::CashRebate.new(user, params).pass?
  end

  def movie_ticket_conditions
    errors.add(:base, 'You can not claim movie ticket') unless Rewards::Validations::MovieTicket.new(user, params).pass?
  end
end