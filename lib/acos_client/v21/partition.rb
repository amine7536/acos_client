require 'acos_client/errors'
require 'acos_client/v21/base'


module AcosClient
  module V21

    class Partition < AcosClient::V21::BaseV21

      def exists(name)

        if name == 'shared'
          return true
        end

        begin
          self._post('system.partition.search', params: {:name => name})
          return true
        rescue AcosClient::Error::NotFound
          return false
        end
      end

      def active(name='shared')
        if self.client.current_partition != name
          self._post('system.partition.active', params: {:name => name})
          self.client.current_partition = name
        end
      end

      def create(name)
        params = {
            :partition => {
                :max_aflex_file => 32,
                :network_partition => 0,
                :name => name
            }
        }
        if name != 'shared'
          self._post('system.partition.create', params: params)
        end
      end

      def delete(name)
        if name != 'shared'
          self.client.session.close
          self._post('system.partition.delete', params: {:name => name})
        end
      end

    end
  end
end