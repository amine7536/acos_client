require 'acos_client/errors'
require 'acos_client/v21/base'

module AcosClient
  module V21

class BasePersistence < AcosClient::V21::BaseV21

  # def initialize(client)
  #   super(client)
  #   @prefix = "slb.template.#{@pers_type}_persistence"
  # end

  def all(**opts)
    self._get("#{@prefix}.getAll", **opts)
  end

  def get(name, **opts)
    self._post("#{@prefix}.search", params: {:name => name}, **opts)
  end

  def exists(name, **opts)
    begin
      self.get(name, **opts)
      return true
    rescue AcosClient::Error::NotFound
      return false
    end
  end


  def create(name, **opts)
    self._post("#{@prefix}.create", params: self.get_params(name), **opts)
  end

  def delete(name, **opts)
    self._post("#{@prefix}.delete", params: {:name => name}, **opts)
  end

end


class CookiePersistence < BasePersistence

  def initialize(client)
    super(client)
    @pers_type = 'cookie'
    @prefix = "slb.template.#{@pers_type}_persistence"
  end

  def get_params(name)
    {
        :cookie_persistence_template => {
            :name => name
        }
    }
  end
end


class SourceIpPersistence < BasePersistence

  def initialize(client)
    super(client)
    @pers_type = 'src_ip'
    @prefix = "slb.template.#{@pers_type}_persistence"
  end

  def get_params(name)
    {
        :src_ip_persistence_template => {
            :name => name
        }
    }
  end
end

end
end