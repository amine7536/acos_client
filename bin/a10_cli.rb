#!/usr/bin/env ruby

# For security reasons, ensure that '.' is not on the load path
# This is primarily for 1.8.7 since 1.9.2+ doesn't put '.' on the load path
$LOAD_PATH.delete '.'

# Bundler and rubygems maintain a set of directories from which to
# load gems. If Bundler is loaded, let it determine what can be
# loaded. If it's not loaded, then use rubygems. But do this before
# loading any facter code, so that our gem loading system is sane.
if not defined? ::Bundler
  begin
    require 'rubygems'
  rescue LoadError
    #pass
  end
end

require 'acos_client'

begin
  AcosClient::Application.run(ARGV)

rescue Errno::ENOENT => err

  abort "AcosClient: #{err.message}"

rescue OptionParser::InvalidOption => err

  abort "AcosClient: #{err.message}"
end     
