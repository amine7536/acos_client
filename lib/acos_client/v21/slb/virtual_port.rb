  require 'acos_client/v21/base'

  module AcosClient
    module V21

      class VirtualPort < AcosClient::V21::BaseV21

    # Protocols
    TCP = 2
    UDP = 3
    HTTP = 11
    HTTPS = 12
    OTHERS = 4
    RTSP = 5
    FTP = 6
    MMS = 7
    SIP = 8
    FAST_HTTP = 9
    GENERIC_PROXY = 10
    SSL_PROXY = 13
    SMTP = 14
    SIP_TCP = 15
    SIPS = 16
    DIAMETER = 17
    DNS_UDP = 18
    TFTP = 19
    DNS_TCP = 20
    RADIUS = 21
    MYSQL = 22
    MSSQL = 23
    FIX = 24
    SMPP_TCP = 25
    SPDY = 26
    SPDYS = 27
    FTP_PROXY = 28

    def _set(action, virtual_server_name, name, protocol, port, service_group_name,
     s_pers_name=nil, c_pers_name=nil, status=1, **opts)
    params = {
      :name => virtual_server_name,
      :vport => {
        :name => name,
        :service_group => service_group_name,
        :protocol => protocol,
        :port => port.to_i,
        :source_ip_persistence_template => s_pers_name,
        :cookie_persistence_template => c_pers_name,
        :status => status
        }.compact!
      }
      self._post(action, params: params, **opts)
    end


    def create(virtual_server_name, name, protocol, port, service_group_name, s_pers_name=nil, c_pers_name=nil,
     status=1, **opts)

    self._set('slb.virtual_server.vport.create', virtual_server_name, name, protocol, port, service_group_name,
      s_pers_name, c_pers_name, status, **opts)
  end


  def update(virtual_server_name, name, protocol, port,
   service_group_name,
   s_pers_name=nil, c_pers_name=nil, status=1, **opts)
  self._set('slb.virtual_server.vport.update', virtual_server_name,
    name, protocol, port, service_group_name,
    s_pers_name, c_pers_name, status, **opts)
  end


  def delete(virtual_server_name, name, protocol, port, **opts)
    params = {
      :name => virtual_server_name,
      :vport => {
        :name => name,
        :protocol => protocol,
        :port => port.to_i
      }
    }
    self._post('slb.virtual_server.vport.delete', params: params, **opts)
  end

  end

  end
  end