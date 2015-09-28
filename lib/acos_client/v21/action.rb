require 'acos_client/errors'
require 'acos_client/v21/base'

module AcosClient
  module V21

    class Action < AcosClient::V21::BaseV21

      def write_memory
        begin
          self._get('system.action.write_memory')
        rescue AcosClient::Error::InvalidPartitionParameter
          #pass
        end
      end

      def reboot(**opts)
        raise NotImplementedError, 'Reboot Action is not implemented'
        # return self._post('system.action.reboot', **opts)
      end

      def reload(write_memory: false, **opts)
        # write_memory param is required but no matter what value is passed
        # it will ALWAYS save pending changes

        if write_memory
          write_memory = 1
        else
          write_memory = 0
        end

        self._post('system.action.reload', params: {:write_memory => write_memory}, **opts)
      end
    end
  end
end
