require 'acos_client/v21/base'

module AcosClient
  module V21

class VirtualService < AcosClient::V21::BaseV21

  def all(**opts)
    self._get('slb.virtual_service.getAll', **opts)
  end

  def get(name, **opts)
    self._post('slb.virtual_service.search', params: {:name => name}, **opts)
  end

  def _set(action, name, protocol, port, address, service_group, **opts)
    params = {
        :virtual_service => {
            :port => port,
            :protocol => protocol,
            :name => name,
            :address => address,
            :service_group => service_group
        }
    }
    self._post(action, params: params, **opts)
  end


  def create(name, protocol, port, address, service_group, **opts)
    self._set('slb.virtual_service.create', name, protocol, port, address, service_group, **opts)
  end


  def update(name, protocol, port, address, service_group, **opts)
    self._set('slb.virtual_service.update', name, protocol, port, address, service_group, **opts)
  end


  def delete(name, **opts)
    self._post('slb.virtual_service.delete', params: {:name => name}, **opts)
  end


  def all_delete(**opts)
    self._get('slb.virtual_service.deleteAll', **opts)
  end


  def stats(name, **opts)
    self._post('slb.virtual_service.fetchStatistics', params: {:name => name}, **opts)
  end


  def all_stats(**opts)
    self._get('slb.virtual_service.fetchAllStatistics', **opts)
  end
end

end
end
