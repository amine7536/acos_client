module OpenSSL
  module SSL
    class SSLContext
      remove_const(:DEFAULT_PARAMS)
      DEFAULT_PARAMS = {
          :ssl_version => 'TLSv1',
          :verify_mode => OpenSSL::SSL::VERIFY_PEER,
          :ciphers => %w{
          DES-CBC3-SHA
        }.join(':'),
          :options => -> {
            opts = OpenSSL::SSL::OP_ALL
            opts &= ~OpenSSL::SSL::OP_DONT_INSERT_EMPTY_FRAGMENTS if defined?(OpenSSL::SSL::OP_DONT_INSERT_EMPTY_FRAGMENTS)
            opts |= OpenSSL::SSL::OP_NO_COMPRESSION if defined?(OpenSSL::SSL::OP_NO_COMPRESSION)
            opts |= OpenSSL::SSL::OP_NO_SSLv2 if defined?(OpenSSL::SSL::OP_NO_SSLv2)
            opts |= OpenSSL::SSL::OP_NO_SSLv3 if defined?(OpenSSL::SSL::OP_NO_SSLv3)
            opts
          }.call
      }
    end
  end
end