module API::V1
  class LoyaltyPoints < API::V1::Base

    resource :loyalty_points do

      #POST /api/loyalty_points
      post do
        service = ::LoyaltyPoints::Issuer.new(current_user, params)
        if service.run
          present service.points_log
        else
          error!({ messages: service.errors.full_messages }, 500)
        end
      end
    end
  end
end
