require 'acos_client/v21/base'

module AcosClient
  module V21

    class HA < AcosClient::V21::BaseV21

      def sync(destination_ip, username, password)

        params = {
            :ha_config_sync => {
                :auto_authentication => 0,
                :user => username,
                :password => password,
                :sync_all_partition => 1,
                :operation => 2, # running config only
                :peer_operation => 0, # running config
                :peer_reload => 0,
                :destination_ip => destination_ip
            }
        }

        self._post('ha.sync_config', params: params)
      end

    end

  end
end
