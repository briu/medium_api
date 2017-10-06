module Requests
  module JsonHelpers
    def json
      JSON.parse(last_response.body).with_indifferent_access
    end
  end
end
