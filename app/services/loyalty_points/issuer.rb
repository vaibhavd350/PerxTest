class LoyaltyPoints::Issuer
  include ActiveModel::Model

  attr_accessor :points_log
  attr_reader :params, :client

  LOCAL_POINTS_CONVERSION = 0.1
  FOREIGN_POINTS_CONVERSION = 0.2

  validate :end_user_present

  def initialize(client, params)
    @params = params
    @client = client
  end

  def run
    if valid?
      issue_points
    end
    errors.empty?
  rescue => e
    errors.add(:base, e.message)
    errors.empty?
  end

  private

  def issue_points
    return if points_earned.zero?
    @points_log = PointsLog.create!(points_earned: points_earned,
                                    issued_by: client.id,
                                    user_id: end_user.id,
                                    valid_until: Date.today + 1.year)
  end

  def end_user_present
    end_user.present?
  end

  def end_user
    User.find(params[:end_user_id].to_i) rescue nil
  end

  def points_earned
    local_transaction_points + foreign_transaction_points
  end

  def local_transaction_points
    (local_transaction_amount_with_client * LOCAL_POINTS_CONVERSION).to_i
  end

  def foreign_transaction_points
    (foreign_transaction_amount_with_client * FOREIGN_POINTS_CONVERSION).to_i
  end

  def local_transaction_amount_with_client
    return 0 unless end_user.present?
    end_user.client_transactions.where(client_id: client.id, currency: end_user.currency).sum(:amount).to_i
  end

  def foreign_transaction_amount_with_client
    return 0 unless end_user.present?
    end_user.client_transactions.where(client_id: client.id).where.not(currency: [nil,end_user.currency]).sum(:amount).to_i
  end
end