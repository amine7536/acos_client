#from member import Member

require 'acos_client/errors'
require 'acos_client/v21/base'
require 'acos_client/v21/slb/member'

module AcosClient
  module V21
    class ServiceGroup < AcosClient::V21::BaseV21

      def member
        Member.new(self.client)
      end

      # Valid LB methods
      ROUND_ROBIN = 0
      WEIGHTED_ROUND_ROBIN = 1
      LEAST_CONNECTION = 2
      WEIGHTED_LEAST_CONNECTION = 3
      LEAST_CONNECTION_ON_SERVICE_PORT = 4
      WEIGHTED_LEAST_CONNECTION_ON_SERVICE_PORT = 5
      FAST_RESPONSE_TIME = 6
      LEAST_REQUEST = 7
      STRICT_ROUND_ROBIN = 8
      STATELESS_SOURCE_IP_HASH = 9
      STATELESS_SOURCE_IP_HASH_ONLY = 10
      STATELESS_DESTINATION_IP_HASH = 11
      STATELESS_SOURCE_DESTINATION_IP_HASH = 12
      STATELESS_PER_PACKET_ROUND_ROBIN = 13

      # Valid protocols
      TCP = 2
      UDP = 3

      def get(name, **opts)
        self._post('slb.service_group.search', params: {:name => name}, **opts)
      end

      def _set(action, name, protocol: nil, lb_method: nil, health_monitor: nil, **opts)
        puts opts
        params = {
            :service_group => {
                :name => name,
                :protocol => protocol,
                :lb_method => lb_method,
                :health_monitor => health_monitor
            }#.compact!
        }
        self._post(action, params: params, **opts)
      end

      def create(name, protocol: TCP, lb_method: ROUND_ROBIN, **opts)
        self._set('slb.service_group.create', name, protocol: protocol, lb_method: lb_method, **opts)
      end

      def update(name, protocol: nil, lb_method: nil, health_monitor: nil, **opts)
        self._set('slb.service_group.update', name, protocol: protocol, lb_method: lb_method, health_monitor: health_monitor, **opts)
      end

      def delete(name, **opts)
        self._post('slb.service_group.delete', params: {:name => name}, **opts)
      end

      def all(**opts)
        self._get('slb.service_group.getAll', **opts)
      end

      def delete_all(**opts)
        self._get('slb.service_group.deleteAll', **opts)
      end
    end

  end
end