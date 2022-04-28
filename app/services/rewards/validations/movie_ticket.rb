class Rewards::Validations::MovieTicket < Rewards::Validations::Base
  def pass?
    user_spent_1000_in_60_days && no_previous_similar_redemption
  end

  private

  def user_spent_1000_in_60_days
    return false unless first_transaction.present?
    user.client_transactions.where("created_at >= ?", first_transaction.created_at).sum(:amount).to_i >= 1000
  end

  def first_transaction
    user.client_transactions.first_transaction
  end
end