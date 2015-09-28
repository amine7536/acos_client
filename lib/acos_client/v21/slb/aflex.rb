#from acos_client import multipart
require 'acos_client/v21/base'

module AcosClient
  module V21
#
# Todo: implement multipart upload
#
class Aflex < AcosClient::V21::BaseV21


  def _set(action, name, aflex, **opts)
    # m = multipart.Multipart
    # m.file(name="upload_aflex", filename=name, value=aflex)
    # ct, payload = m.get
    # kwargs.update(payload=payload, headers={'Content-Type': ct})
    #  self._post(action, **opts)
  end


  def upload(name, aflex, **opts)
    self._set('slb.aflex.upload', name, aflex, **opts)
  end


  def update(name, aflex, **opts)
    self._set('slb.aflex.update', name, aflex, **opts)
  end


  def all(**opts)
    self._get('slb.aflex.getAll')
  end


  def get(name, **opts)
    self._post('slb.aflex.search', params: {:name => name}, **opts)
  end


  def download(name, **opts)
    self._post('slb.aflex.download', params: {:name => name}, **opts)
  end


  def delete(name, **opts)
    self._post('slb.aflex.delete', params: {:name => name}, **opts)
  end


  def stats(name, **opts)
    self._post('slb.aflex.fetchStatistics', params: {:name => name}, **opts)
  end


  def all_stats(**opts)
    self._get('slb.aflex.fetchAllstatistics', **opts)
  end


  def clear_stats(name, **opts)
    self._post('slb.aflex.slb.aflex.clearStatistics', params: {:name => name}, **opts)
  end


  def clear_all_stats(**opts)
    self._post('slb.aflex.clearAllStatistics', **opts)
  end


  def clear_events(name, event_name, **opts)
    params = {
        :aflex_event => {
            :name => name,
            :event_name => event_name
        }
    }
    self._post('slb.aflex.clearEvents', params: params, **opts)
  end


  def clear_all_events(**opts)
    self._post('slb.aflax.clearAllEvents', **opts)
  end

end

end
end
