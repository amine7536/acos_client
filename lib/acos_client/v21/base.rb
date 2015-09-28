require 'acos_client/errors'

module AcosClient
  module V21

    class BaseV21

      attr_accessor :client

      def initialize(client)
        @client = client

      end

      def url(action)
        "/services/rest/v2.1/?format=json&method=#{action}&session_id=#{@client.session.id}"
      end

      def _request(method, action, params: params, retry_count: 0, **opts)

        if retry_count > 6
          raise AcosClient::Error::ACOSUnknownError
        end

        begin

          return @client.http.request(method, self.url(action), params: params, **opts)

        rescue AcosClient::Error::MemoryFault => e
          if retry_count < 5
            sleep(0.5)
            return self._request(method, action, params: params, retry_count: retry_count+1, **opts)
          end
          raise e

        rescue AcosClient::Error::InvalidSessionID => e
          if retry_count < 5
            sleep(0.5)
            begin
              p = @client.current_partition
              @client.session.close
              @client.partition.active(p)
            rescue Exception => e
              #pass
            end
            return self._request(method, action, params: params, retry_count: retry_count+1, **opts)
          end
          raise e
        end

      end

      def _get(action, params: {}, **opts)
        self._request('GET', action, params: params, **opts)
      end

      def _post(action, params: {}, **opts)
        self._request('POST', action, params: params, **opts)
      end

    end
  end
end