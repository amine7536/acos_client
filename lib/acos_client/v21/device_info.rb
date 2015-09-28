require 'acos_client/v21/base'

module AcosClient
  module V21

    class DeviceInfo < AcosClient::V21::BaseV21

      def get(**opts)
        self._get('system.device_info.get', **opts)
      end

      def cpu_current_usage(**opts)
        self._get('system.device_info.cpu.current_usage.get', **opts)
      end

      def cpu_historical_usage(**opts)
        self._get('system.device_info.cpu.historical_usage.get', *opts)
      end

    end
  end
end