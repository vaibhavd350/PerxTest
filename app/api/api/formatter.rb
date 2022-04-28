module API
  module Formatter

    def self.call data, env
      {}.tap do |response|
        response[:data] = data
        if data.respond_to? :options
          response[:meta] = data.options[:meta] || {}
        end
      end.to_json
    end
  end
end
