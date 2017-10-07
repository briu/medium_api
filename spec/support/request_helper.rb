module Requests
  module JsonHelpers
    def json
      resp = JSON.parse(last_response.body)
      resp.is_a?(Hash) ? resp.with_indifferent_access : resp
    end
  end
end
