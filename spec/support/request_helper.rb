# frozen_string_literal: true

module Rack
  # Mock JSON parsed response
  class MockResponse
    def parsed_body
      JSON.parse(body)
    end
  end
end
