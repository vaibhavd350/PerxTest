module API
  class Base < Grape::API
    prefix 'api'

    rescue_from :all, :backtrace => true

    formatter :json, API::Formatter

    helpers do
      def authenticate_user
        current_user.present?
      end

      def email_from_token
        return nil unless request.headers["Authorization"].present?
        AuthenticationTokenGenerator.decode(request.headers["Authorization"])
      end

      def current_user
        return nil unless email_from_token.present?
        user = User.find_by(email: email_from_token) || Client.find_by(email: email_from_token)
        @current_user ||= user
      end
    end

    before do
      authenticate_user
    end


    # Rescue from errors
    rescue_from ActiveRecord::RecordNotFound do |e|
      error_response(message: [e.message], status: 404)
    end

    rescue_from ActiveRecord::RecordInvalid do |e|
      error_response(message: [e.message], status: 422)
    end


  mount API::V1::Base
  end
end
