require 'acos_client/v21/base'
require 'acos_client/v21/slb/virtual_port'

module AcosClient
  module V21

class VirtualServer < AcosClient::V21::BaseV21

  def vport
    VirtualPort.new(self.client)
  end

  def all(**opts)
    self._get('slb.virtual_server.getAll', **opts)
  end


  def get(name, **opts)
    self._post('slb.virtual_server.search', params: {:name => name}, **opts)
  end

  def _set(action, name, ip_address=nil, status=1, **opts)
    params = {
        :virtual_server => {
            :name => name,
            :address => ip_address,
            :status => status,
        }#.compact!
    }
    self._post(action, params: params, **opts)

  end


  def create(name, ip_address, status=1, **opts)
    self._set('slb.virtual_server.create', name, ip_address, status, **opts)
  end


  def update(name, ip_address=nil, status=1, **opts)
    self._set('slb.virtual_server.update', name, ip_address, status, **opts)
  end


  def delete(name, **opts)
    self._post('slb.virtual_server.delete', params: {:name => name}, **opts)
  end


  def stats(name, **opts)
    self._post('slb.virtual_server.fetchStatistics', params: {:name => name}, **opts)
  end


  def all_stats(**opts)
    self._get('slb.virtual_server.fetchAllStatistics', **opts)
  end
end

end
end

