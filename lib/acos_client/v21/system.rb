require 'acos_client/v21/base'
require 'acos_client/v21/device_info'
require 'acos_client/v21/action'
require 'acos_client/v21/partition'
require 'acos_client/v21/log'
require 'acos_client/v21/config_file'


module AcosClient
  module V21
    class System < AcosClient::V21::BaseV21

      def backup(**opts)
        self._get('system.backup', **opts)
      end

      def restore(name, data, **opts)
        raise NotImplementedError, 'Restore Action is not implemented'
        # m = multipart.Multipart()
        # m.file(name="restore", filename=name, value=data)
        # ct, payload = m.get()
        # kwargs.update(payload=buffer(payload), headers={'Content-Type': ct})
        #  self._post("system.restore")
      end

      def tech_download
        self._get('system.show_tech.download')
      end

      def information
        self._get('system.information.get')
      end

      def device_info
        DeviceInfo.new(self.client)
      end

      def action
        Action.new(self.client)
      end

      def partition
        Partition.new(self.client)
      end

      def config_file
        ConfigFile.new(self.client)
      end

      def log
        Log.new(self.client)
      end

      def banner
        Banner.new(self.client)
      end

      class Banner < AcosClient::V21::BaseV21
        def get(**opts)
          self._get('system.banner.get', **opts)
        end

        def set(banner, **opts)
          self._post('system.log.banner.set', params: {:banner => banner}, **opts)
        end
      end

      def hostname
        Hostname.new(self.client)
      end

      class Hostname < AcosClient::V21::BaseV21
        def get(**opts)
          self._get('system.hostname.get', **opts)
        end

        def set(hostname, **opts)
          self._post('system.hostname.set', params: {:hostname => hostname}, **opts)
        end
      end

    end
  end
end