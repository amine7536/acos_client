require 'acos_client/v21/base'

module AcosClient
  module V21

    class Port < AcosClient::V21::BaseV21

      # Protocols
      TCP = 2
      UDP = 3

      def _set(action, name, port_num, protocol, **opts)

        params = {
            :name => name,
            :port => {
                :port_num => port_num,
                :protocol => protocol,
            }
        }

        self._post(action, params: params, **opts)

      end

      def create(name, port_num, protocol, **opts)
        self._set('slb.server.port.create', name, port_num, protocol, **opts)
      end


      def update(name, port_num, protocol, **opts)
        self._set('slb.server.port.update', name, port_num, protocol, **opts)
      end

      def all_update(name, port_num, protocol, **opts)
        self._set('slb.server.port.updateAll', name, port_num, protocol, **opts)
      end

      def delete(name, port_num, protocol, **opts)
        self._set('slb.server.port.delete', name, port_num, protocol, **opts)
      end

      def all_delete(name, **opts)
        self._get('slb.server.port.deleteAll', params: {:name => name}, **opts)
      end

    end

  end
end


