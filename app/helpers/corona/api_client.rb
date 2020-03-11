require 'rest-client'

module Corona
  class ApiClient
    class << self
      def request(request, req_method = :get, payload = {})
        url = "#{api_url}/#{request}"
        filters = {
          method: req_method,
          payload: payload.to_json,
          headers: headers,
          url: url
        }

        Logger.new.debug("Request Body: #{payload}") if %i[post put patch].include?(req_method)

        JSON.parse rest_client.execute(filters)
      end

      private

      def api_url
        @api_url ||= ENV['API_URL'] || 'https://apigw.nubentos.com:443'
      end

      def api_key
        @api_key ||= ENV['API_KEY'] || '41ccd0ad-d744-30d2-9cc1-6b69804276d3'
      end

      def rest_client
        @rest_client ||= RestClient::Request
      end

      def headers
        {
          'Content-Type' => 'application/json',
          'Authorization' => "Bearer #{api_key}"
        }
      end
    end
  end
end