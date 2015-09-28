require 'acos_client/v21/base'
require 'acos_client/v21/slb/template/persistence'
require 'acos_client/v21/slb/template/template_ssl'

module AcosClient
  module V21
    class Template < AcosClient::V21::BaseV21

      def client_ssl
        ClientSSL.new(self.client)
      end

      def server_ssl
        ServerSSL.new(self.client)
      end

      def cookie_persistence
        CookiePersistence.new(self.client)
      end

      def src_ip_persistence
        SourceIpPersistence.new(self.client)
      end

    end

  end
end
