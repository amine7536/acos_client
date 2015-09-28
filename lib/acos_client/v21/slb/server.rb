require 'acos_client/v21/base'
require 'acos_client/v21/slb/port'

module AcosClient
  module V21
    class Server < AcosClient::V21::BaseV21

      def get(name, **opts)
        self._post('slb.server.search', params: {:name => name}, **opts)
      end

      def create(name, ip_address, **opts)
        params = {
            :server => {
                :name => name,
                :host => ip_address,
            }
        }
        self._post('slb.server.create', params: params, **opts)
      end


      def update(name, ip_address, **opts)
        params = {
            :server => {
                :name => name,
                :host => ip_address,
                :status => opts.fetch(:status, 1) # Use update(name, ip_address, {:status => 0})
            }
        }
        self._post('slb.server.update', params: params, **opts)
      end


      def fetch_statistics(name, **opts)
        self._post('slb.server.fetchStatistics', params: {:name => name}, **opts)
      end

      def delete(name, **opts)
        self._post('slb.server.delete', params: {:server => {:name => name}}, **opts)
      end

      def all
        self._get('slb.server.getAll')
      end

      def all_delete(**opts)
        self._get('slb.server.deleteAll', **opts)
      end

      def stats(name, **opts)
        self._post('slb.server.fetchStatistics', params: {:server => {:name => name}}, **opts)
      end

      def all_stats(**opts)
        self._get('slb.server.fetchAllStatistics', **opts)
      end

      def port
        Port.new(self.client)
      end

    end
  end
end