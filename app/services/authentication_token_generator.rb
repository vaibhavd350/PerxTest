class AuthenticationTokenGenerator
  SECRET_KEY = Rails.application.secrets.secret_key_base

  class << self
    def encode(data)
      payload = {data: data}
      JWT.encode(payload, SECRET_KEY)
    end

    def decode(token)
      decoded = JWT.decode(token, SECRET_KEY)[0]
      HashWithIndifferentAccess.new(decoded)["data"]
    end
  end
end