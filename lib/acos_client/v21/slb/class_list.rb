require 'json'
#require 'regexp'
require 'acos_client/v21/base'


module AcosClient
  module V21
#
# ToDo: add more types
# ToDo: implement multipart upload
#

class ClassList < AcosClient::V21::BaseV21

  IPV4 = 2

  def _fix_json(data)
  #   p = re.compile(r '(?<=[^:{\[,])"(?![:,}\]])')
  #   json.loads(re.sub(p, '\\"', data))
  end

  def all(**opts)
     #self._fix_json(self._get('slb.class_list.getAll', **opts))
     self._get('slb.class_list.getAll', **opts)
  end

  def get(name, **opts)
     self._fix_json(self._post('slb.class_list.search', params: {:name => name}, **opts))
  end

  def download(name, **opts)
     self._post('slb.class_list.download', params: {:file_name => name}, **opts)
  end


  def upload(name, class_list, **opts)
    #m = multipart.Multipart()
    #m.file(name=name, filename=name, value=class_list)
    #ct, payload = m.get()
    #kwargs.update(payload=payload, headers={'Content-Type' : ct})
    # self._post('slb.class_list.upload', **opts)
  end

  def _set(action, class_list, **opts)
     self._post(action, params: {:name => class_list}, **opts)
  end

  def create(class_list, type=IPV4, **opts)
    params = {
        :name => class_list,
        :type => type
    }
    self._post('slb.class_list.create', params: params, **opts)
  end

  def update(class_list, **opts)
     self._set('slb.class_list.update', class_list, **opts)
  end

  def delete(name, **opts)
    self._post('slb.class_list.delete', params: {:name => name}, **opts)
  end

end

end
end