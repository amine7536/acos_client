require 'httparty'
require 'json'
require 'pp'

require 'acos_client/v21/monkey_patch_ssl'
require 'acos_client/tools'
require 'acos_client/v21/responses'

module AcosClient
  module V21

    # Some were fixed in ACOS 2.7.2-P4
    #
    BROKEN_REPLIES = {
        ('<?xml version="1.0" encoding="utf-8" ?>'\
        '<response status="ok">') => ({:response => {:status => 'OK'}}).to_json,

        ('<?xml version="1.0" encoding="utf-8" ?><response status="fail">'\
        '<error code="999" msg=" Partition does not exist. (internal error: 520749062)" />'\
        '</response>') => ({:response => {:status => 'fail', :err => {:code => 999,
                                                                      :msg => ' Partition does not exist.'}}}).to_json,

        ('<?xml version="1.0" encoding="utf-8" ?><response status="fail">'\
        '<error code="1076" msg="Invalid partition parameter." /></response>') => ({
            :response => {:status => 'fail', :err => {:code => 1076, :msg => 'Invalid partition parameter.'}}}).to_json,

        ('<?xml version="1.0" encoding="utf-8" ?><response status="fail">'\
        '<error code="999" msg=" No such aFleX. (internal error: '\
        '17039361)" /></response>') => ({:response => {:status => 'fail', :err => {:code => 17039361,
                                                                                   :msg => ' No such aFleX.'}}}).to_json,

        ('<?xml version="1.0" encoding="utf-8" ?><response status="fail">'\
        '<error code="999" msg=" This aFleX is in use. (internal error: '\
        '17039364)" /></response>') => ({:response => {:status => 'fail', :err => {:code => 17039364,
                                                                                   :msg => ' This aFleX is in use.'}}}).to_json
    }

    class HttpClient
      include HTTParty

      #default_options[:ssl_version] = :TLSv1
      ssl_version :TLSv1
      default_options.update(verify: false)

      HEADERS = {
          'Content-type' => 'application/json',
          'User-Agent' => "ACOS-Ruby-Client-AGENT-#{VERSION}",
      }

      attr_accessor :host, :port, :protocol

      def initialize(host, protocol: 'https', port: nil)

        @host = host
        @port = port
        @protocol = protocol

        if port.nil?
          if protocol == 'http'
            @port = 80
          else
            @port = 443
          end
        end

        @base_uri = @protocol + '://' + @host + ':' + @port.to_s
        self.class.base_uri(@base_uri)
      end

      def request(method, api_url, params: {}, ** opts)
        #
        # Todo: Catch http/httparty exceptions
        #

        params_copy = {}
        if !params.empty?
          params_copy = params.merge(opts)
        end

        options = {
            :body => params_copy.to_json,
            :headers => HEADERS
        }

        case method

          when 'GET'
            r = self.class.get(api_url, params)
            response = r.body

            begin
              r.inspect

            rescue JSON::ParserError
              # ToDo: should check broken replies
            end

          when 'POST'
            r = self.class.post(api_url, options)
            response = r.body

            begin
              r.inspect

            rescue JSON::ParserError
              # Extract "<?xml version="1.0" encoding="utf-8" ?><response status="ok">"
              xmlhead = r.body[0..60]

              if BROKEN_REPLIES.key?(xmlhead)
                response = BROKEN_REPLIES[xmlhead]
              elsif BROKEN_REPLIES.key?(r.body.to_s)
                response = BROKEN_REPLIES[r.body.to_s]
              end

            end

          else
            raise RuntimeError
        end

        r = JSON.load(response).deep_symbolize_keys!
        if r.key?(:response) and r[:response].key?(:status)
          if r[:response][:status] == 'fail'
            AcosClient::V21::Responses.raise_axapi_error(r, action: AcosClient::Tools.extract_method(@base_uri + api_url))
          end
        end

        r
      end

      def get(api_url, params: {}, ** opts)
        self.request('GET', api_url, params: params)
      end

      def post(api_url, params: {}, ** opts)
        self.request('POST', api_url, params: params)
      end

    end

  end

end