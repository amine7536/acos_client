require 'acos_client/v21/base'

module AcosClient
  module V21
    class Nat < AcosClient::V21::BaseV21

      def pool
        Pool.new(self.client)
      end

      class Pool < AcosClient::V21::BaseV21

        def _set(action, name, start_ip, end_ip, mask, **opts)

          params = {
              :name => name,
              :start_ip_addr => start_ip,
              :end_ip_addr => end_ip,
              :netmask => mask,
          }

          self._post(action, params: params, **opts)
        end

        def all(**opts)
          self._get('nat.pool.getAll', **opts)
        end

        def create(name, start_ip, end_ip, mask, **opts)
          self._set('nat.pool.create', name, start_ip, end_ip, mask, **opts)
        end

        def update(name, start_ip, end_ip, mask, **opts)
          self._set('nat.pool.create', name, start_ip, end_ip, mask, **opts)
        end

        def delete(name, **opts)
          self._post('nat.pool.delete', params: {:name => name}, **opts)
        end

        def stats(name, **opts)
          self._post('nat.pool.fetchStatistics', params: {:name => name}, **opts)
        end

        def all_stats(**opts)
          self._get('nat.pool.fetchALLStatistics', **opts)
        end

      end

    end
  end
end