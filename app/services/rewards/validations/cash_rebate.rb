class Rewards::Validations::CashRebate < Rewards::Validations::Base
  def pass?
    user_spent_more_than_100_in_more_than_10_transactions && no_previous_similar_redemption
  end

  private

  def user_spent_more_than_100_in_more_than_10_transactions
    user.client_transactions.collect{ |s| s.amount >= 100 }.length >= 10
  end
end