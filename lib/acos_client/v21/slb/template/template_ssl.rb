require 'acos_client/v21/base'

module AcosClient
  module V21
class BaseSSL < AcosClient::V21::BaseV21

  def all(**opts)
    self._get("slb.template.#{@template_type}.getAll", **opts)
  end

  def get(name, **opts)
      self._post("slb.template.#{@template_type}.search", params: {:name => name}, **opts)
    end

    def _set(action, name, cert_name, key_name, **opts)
      template = "#{@template_type}_template"

      params = {
            template => {
            :cert_name => cert_name,
            :key_name => key_name,
            :name => name
          }
        }.deep_symbolize_keys!
      self._post(action, params: params, **opts)
    end

    def create(name, cert_name, key_name, **opts)
        self._set("slb.template.#{@template_type}.create", name, cert_name, key_name, **opts)
    end

    def update(name, cert_name, key_name, **opts)
        self._set("slb.template.#{@template_type}.update", name, cert_name, key_name, **opts)
    end

    def delete(name, **opts)
        self._post("slb.template.#{@template_type}.delete", params: {:name => name}, **opts)
    end
end

class ClientSSL < BaseSSL
  def initialize(client)
    super(client)
    @template_type = 'client_ssl'
  end
end

class ServerSSL < BaseSSL
  def initialize(client)
    super(client)
    @template_type = 'server_ssl'
  end
end

end
end