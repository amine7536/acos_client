require 'acos_client/v21/axapi_http'
require 'acos_client/v21/session'
require 'acos_client/v21/ha'
require 'acos_client/v21/system'
require 'acos_client/v21/slb/init'
require 'acos_client/v21/network'
require 'acos_client/v21/nat'


module AcosClient

  class Client

    # VERSION_IMPORTS = {
    # :21 = {
    # 	:HA => :v21_HA,
    # 	:Nat => :v21_Nat,
    # 	:Network => :v21_Network,
    # 	:Session => :v21_Session,
    # 	:SLB => :v21_SLB,
    # 	:System => :v21_System,
    # 	}
    # }

    attr_accessor :http, :session, :system, :current_partition

    def initialize(username, password, host, protocol: 'https', port: nil)

      @http = AcosClient::V21::HttpClient.new(host, protocol: protocol, port: port)
      @session = AcosClient::V21::Session.new(self, username, password)
      @current_partition = 'shared'

    end

    def ha
      AcosClient::V21::HA.new(self)
    end

    def system
      AcosClient::V21::System.new(self)
    end

    def slb
      AcosClient::V21::SLB.new(self)
    end

    def network
      AcosClient::V21::Network.new(self)
    end

    def nat
      AcosClient::V21::Nat.new(self)
    end


  end

end
