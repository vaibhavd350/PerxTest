class Client < ApplicationRecord
  has_many :user_transactions, foreign_key: "client_id", class_name: 'UserClientTransaction'
  
  def authentication_token
    AuthenticationTokenGenerator.encode(self.email)
  end
end
