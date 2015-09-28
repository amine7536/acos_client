require 'acos_client/errors'
require 'acos_client/v21/base'


module AcosClient
  module V21

    class Member < AcosClient::V21::BaseV21

      def _write(action, service_group_name, server_name, server_port, status=nil, **opts)
        params = {
            :name => service_group_name,
            :member => {
                :server => server_name,
                :port => server_port.to_i,
                :status => status
            }#.compact!
        }
        self._post(action, params: params, **opts)
      end

      def create(service_group_name, server_name, server_port, status=1, **opts)
        self._write('slb.service_group.member.create', service_group_name, server_name, server_port, status, **opts)
      end

      def update(service_group_name, server_name, server_port, status=1, **opts)
        self._write('slb.service_group.member.update', service_group_name, server_name, server_port, status, **opts)
      end

      def delete(service_group_name, server_name, server_port, **opts)
        self._write('slb.service_group.member.delete', service_group_name, server_name, server_port, **opts)
      end
    end

  end
end
