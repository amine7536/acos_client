require 'acos_client/v21/base'

module AcosClient
  module V21

    class Log < AcosClient::V21::BaseV21

      def set(sys_log, **opts)
        params = {:sys_log => sys_log}
        self._post('system.log.set', params: params, **opts)
      end


      def get(**opts)
        self._get('system.log.get', **opts)
      end


      def clear(sys_log, **opts)
        self._post('system.log.clear', **opts)
      end


      def download(**opts)
        self._get('system.log.download', **opts)
      end


      def backup(**opts)
        self._post('system.log.backup', **opts)
      end


      def level
        Level.new(self.client)
      end

      class Level < AcosClient::V21::BaseV21
        def get(**opts)
          self._get('system.log.level.get', **opts)
        end

        def set(log_level, **opts)
          params = {:log_level => log_level}
          self._post('system.log.level.set', params: params, **opts)
        end
      end


      def server
        Server.new(self.client)
      end

      class Server < AcosClient::V21::BaseV21
        def get(**opts)
          self._get('system.log.server.get', **opts)
        end

        def set(log_server, **opts)
          params = {:log_server => log_server}
          self._post('system.log.server.set', params: params, **opts)
        end
      end


      def buffer
        Buffer.new(self.client)
      end

      class Buffer < AcosClient::V21::BaseV21
        def get(**opts)
          self._get('system.log.buffer.get', **opts)
        end

        def set(buff_size, **opts)
          params = {:buffer_size => buff_size}
          self._post('system.log.buffer.set', params: params, **opts)
        end
      end


      def smtp
        Smtp.new(self.client)
      end

      class Smtp < AcosClient::V21::BaseV21
        def get(**opts)
          self._get('system.log.smtp.get', **opts)
        end

        def set(smtp, **opts)
          params = {:smtp => smtp}
          self._post('system.log.smtp.set', params: params, **opts)
        end
      end


      def audit
        Audit.new(self.client)
      end

      class Audit < AcosClient::V21::BaseV21
        def get(**opts)
          self._get('system.log.audit.get', **opts)
        end

        def set(audit, **opts)
          params = {:audit => audit}
          self._post('system.log.audit.set', params: params, **opts)
        end

      end

    end

  end
end