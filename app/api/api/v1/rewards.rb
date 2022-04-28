module API::V1
  class Rewards < API::V1::Base

    resource :rewards do

      #POST /api/rewards
      post do
        service = ::Rewards::Assigner.new(current_user, params)
        if service.run
          present service.reward
        else
          error!({ messages: service.errors.full_messages }, 500)
        end
      end
    end
  end
end
