require 'acos_client/errors'
require 'acos_client/v21/base'


module AcosClient
  module V21
    class HealthMonitor < AcosClient::V21::BaseV21

      # Valid types
      ICMP = 0
      TCP = 1
      HTTP = 3
      HTTPS = 4

      def get(name, **opts)
        self._post('slb.hm.search', params: {:name => name}, **opts)
      end

      def _set(action, name, mon_type, interval, timeout, max_retries, method: nil, url: nil, expect_code: nil,
               port: nil, **opts)
        defs = {
            :HTTP => {
                :protocol => 'http',
                :port => 80
            },
            :HTTPS => {
                :protocol => 'https',
                :port => 443
            },
            :ICMP => {
                :protocol => 'icmp',
            },
            :TCP => {
                :protocol => 'tcp',
                :port => 80
            }
        }


        params = {
            :retry => max_retries,
            :name => name,
            :consec_pass_reqd => max_retries,
            :interval => interval,
            :timeout => timeout,
            :disable_after_down => 0,
            :type => mon_type
        }

        if defs.key?(mon_type)

          params[defs[mon_type][:protocol]] = {
              :url => "#{method} #{url}",
              :expect_code => expect_code
          }

          #n = port or n = defs[mon_type].fetch(:port, nil)
          if !port.nil?
            n = port
          else
            n = defs[mon_type].fetch(:port, nil)
          end

          if n
            params[defs[mon_type][:protocol]]['port'] = n
          end
        end

        begin
          self._post(action, params: params, **opts)
        rescue AcosClient::Error::HMMissingHttpPassive
          # Some version of AxAPI 2.1 require this arg
          params[defs[mon_type][:protocol]][:passive] = 0
          self._post(action, params: params, **opts)
        end

      end

      def create(name, mon_type, interval, timeout, max_retries,
                 method: nil,
                 url: nil,
                 expect_code: nil,
                 port: nil, **opts)

        self._set('slb.hm.create', name, mon_type, interval, timeout, max_retries,
                  method: method,
                  url: url,
                  expect_code: expect_code,
                  port: port, **opts)
      end

      # Example call
      # ._set('slb.hm.create',
      #        'testHM',
      #        :HTTP,
      #        60,
      #        60,
      #        5,
      #        method: "method",
      #        url: "url",
      #        expect_code: "expect_code",
      #        port: 99999)

      def update(name, mon_type, interval, timeout, max_retries,
                 method: nil,
                 url: nil,
                 expect_code: nil,
                 port: nil, **opts)

        self._set('slb.hm.update', name, mon_type, interval, timeout, max_retries,
                  method: method,
                  url: url,
                  expect_code: expect_code,
                  port: port, **opts)
      end

      def delete(name, **opts)
        self._post('slb.hm.delete', params: {:name => name}, **opts)
      end
    end
  end
end