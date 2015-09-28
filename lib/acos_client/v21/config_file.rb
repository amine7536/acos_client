require 'acos_client/v21/base'

module AcosClient
  module V21
    class ConfigFile < AcosClient::V21::BaseV21

      def upload(cfg_backup, **opts)
        self._post('system.config_file.upload', params: cfg_backup, **opts)
      end


      def restore(**opts)
        self._post('system.config_file.restore', **opts)
      end


      def write(from_file, to_file, **opts)
        params = {:from => from_file, :to => to_file}
        self._post('system.config_file.write', params: params, **opts)
      end
    end

  end
end


