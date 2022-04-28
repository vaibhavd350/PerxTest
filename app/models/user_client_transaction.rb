class UserClientTransaction < ApplicationRecord
  belongs_to :client
  belongs_to :user

  class << self
    def first_transaction
      order('created_at ASC').first
    end
  end
end
