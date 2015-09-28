require 'acos_client/errors'

module AcosClient
  module V21

    class Session

      def initialize(client, username, password)
        @client = client
        @http = client.http
        @username = username
        @password = password
        @session_id = nil
      end

      def id
        if @session_id.nil?
          self.authenticate(@username, @password)
        end
        @session_id
      end

      def authenticate(username, password)
        url = '/services/rest/V2.1/?format=json&method=authenticate'

        options = {
            :username => username,
            :password => password
        }

        if @session_id.nil?
          self.close
        end

        r = @http.post(url, params: options)
        @session_id = r[:session_id]
        r
      end

      def close
        begin
          @client.partition.active
        rescue Exception
          #pass
        end

        begin
          url = "/services/rest/v2.1/?format=json&method=session.close&session_id=#{@session_id}"
          r = @http.post(url, params: {:session_id => @session_id})

        rescue AcosClient::Error::InvalidPartitionParameter
          #pass
        ensure
          @session_id = nil
        end

        r
      end
    end
  end
end