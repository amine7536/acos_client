require 'acos_client/v21/base'
require 'acos_client/v21/slb/server'
require 'acos_client/v21/slb/hm'
require 'acos_client/v21/slb/service_group'
require 'acos_client/v21/slb/virtual_service'
require 'acos_client/v21/slb/virtual_server'
require 'acos_client/v21/slb/class_list'
require 'acos_client/v21/slb/aflex'
require 'acos_client/v21/slb/template/init'


module AcosClient
  module V21
    class SLB < AcosClient::V21::BaseV21

      DOWN = 0
      UP = 1

      def hm
        HealthMonitor.new(@client)
      end

      def server
        Server.new(@client)
      end

      def service_group
        ServiceGroup.new(@client)
      end

      def template
        Template.new(@client)
      end

      def virtual_server
        VirtualServer.new(@client)
      end

      def aflex
        Aflex.new(@client)
      end

      def class_list
        ClassList.new(@client)
      end

      def virtual_service
        VirtualService.new(@client)
      end

    end
  end
end
