require 'acos_client/errors'


module AcosClient
  module V21
    module Responses

      RESPONSE_CODES = {
          999 => {
              ('*') => AcosClient::Error::NotFound
          },
          1002 => {
              ('*') => AcosClient::Error::MemoryFault
          },
          1009 => {
              ('session.close') => nil,
              ('*') => AcosClient::Error::InvalidSessionID
          },
          1023 => {
              ('slb.service_group.member.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          1043 => {
              ('slb.virtual_server.vport.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          1076 => {
              ('session.close') => nil,
              ('*') => AcosClient::Error::InvalidPartitionParameter
          },
          1163 => {
              ('*') => AcosClient::Error::InvalidParameter
          },
          1165 => {
              ('*') => AcosClient::Error::HMMissingHttpPassive
          },
          1405 => {
              ('*') => AcosClient::Error::Exists
          },
          1406 => {
              ('*') => AcosClient::Error::Exists
          },
          1982 => {
              ('*') => AcosClient::Error::Exists
          },
          2941 => {
              ('*') => AcosClient::Error::Exists
          },
          3602 => {
              ('slb.class_list.update') => AcosClient::Error::NotFound,
              ('*') => AcosClient::Error::NotFound
          },
          17039361 => {
              ('slb.aflex.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          17039364 => {
              ('slb.aflex.upload') => AcosClient::Error::InUse,
              ('slb.aflex.delete') => AcosClient::Error::InUse,
              ('*') => AcosClient::Error::InUse
          },
          33619968 => {
              ('slb.hm.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          33619969 => {
              ('*') => AcosClient::Error::InUse,
          },
          67174402 => {
              ('slb.server.delete') => nil,
              ('slb.server.port.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          67239937 => {
              ('slb.virtual_server.delete') => nil,
              ('slb.virtual_service.delete') => nil,
              ('slb.virtual_service.update') => AcosClient::Error::NotFound,
              ('*') => AcosClient::Error::NotFound
          },
          67239947 => {
              ('*') => AcosClient::Error::Exists
          },
          67305473 => {
              ('slb.service_group.delete') => nil,
              ('slb.service_group.member.delete') => nil,
              ('slb.service_group.member.create') => AcosClient::Error::NotFound,
              ('slb.service_group.member.update') => AcosClient::Error::NotFound,
              ('*') => AcosClient::Error::NotFound
          },
          67371009 => {
              ('slb.template.cookie_persistence.delete') => nil,
              ('slb.template.src_ip_persistence.delete') => nil,
              ('slb.template.client_ssl.delete') => nil,
              ('slb.template.server_ssl.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          67371049 => {
              ('slb.class_list.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          402653200 => {
              ('*') => AcosClient::Error::Exists
          },
          402653201 => {
              ('*') => AcosClient::Error::Exists
          },
          402653202 => {
              ('*') => AcosClient::Error::Exists
          },
          402653206 => {
              ('*') => AcosClient::Error::Exists
          },
          402718800 => {
              ('*') => AcosClient::Error::NotFound
          },
          520486915 => {
              ('*') => AcosClient::Error::AuthenticationFailure
          },
          520749062 => {
              ('*') => AcosClient::Error::NotFound
          },
          654311465 => {
              ('*') => AcosClient::Error::AddressSpecifiedIsInUse
          },
          654311495 => {
              ('*') => AcosClient::Error::InUse,
          },
          654311496 => {
              ('*') => AcosClient::Error::AddressSpecifiedIsInUse
          },
          654376968 => {
              ('nat.pool.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          },
          654573574 => {
              ('network.acl.ext.delete') => nil,
              ('*') => AcosClient::Error::NotFound
          }
      }


      def self.raise_axapi_error(response, action: nil)

        if response.key?(:response) and response[:response].key?(:err)
          code = response[:response][:err][:code]

          if RESPONSE_CODES.key?(code)
            error_dict = RESPONSE_CODES[code]

            if !action.nil? and error_dict.key?(action)
              error = error_dict[action]
            else
              error = error_dict['*']
            end

            if !error.nil?
              raise error, 'Err: ' + code.to_s + ' ' + response[:response][:err][:msg]
            else
              return
            end
          end
          raise RuntimeError, 'Err: ' + code.to_s + ' ' + response[:response][:err][:msg]
        end

        raise RuntimeError

      end
    end
  end
end