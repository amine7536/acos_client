require 'addressable/uri'


module AcosClient
  module Tools

    def self.extract_method(api_url)
      return Addressable::URI.parse(api_url).query_values['method']
    end

  end
end
