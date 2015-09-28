require 'optparse'
require 'pp'
require 'acos_client/client'
require 'acos_client/v21/responses'

module AcosClient
  module Application

    def self.run(argv)

      c = AcosClient::Client.new('admin', 'a10', '192.168.1.10')

      puts c.session.id
      #c.system.partition.active('shared')

      # System
      #puts c.system.tech_download
      puts c.system.information
      puts c.system.device_info.get
      puts c.system.device_info.cpu_current_usage
      puts c.system.device_info.cpu_historical_usage
      #puts c.system.action.reboot # Not Implemented

      # Partition
      if c.system.partition.exists('test')
        puts c.system.partition.exists('test')
        c.system.partition.active('test')
      else
        #c.system.partition.create("test")
      end
      puts c.current_partition

      # Log

      # Network
      puts c.network.interface.all
      #puts c.network.interface.get(3) # broken
      puts c.network.acl.ext.all
      puts c.nat.pool.all

      # HA Sync
      puts c.ha.sync('127.0.0.1', 'admin', 'a10')

      #####################
      # SLB               #
      #####################

      # Virtual Service
      #
      puts c.slb.virtual_service.all
      begin
        puts c.slb.virtual_service.get('test')
      rescue => e
        puts "#{e.message}"
      end

      # Virtual Server
      #
      puts c.slb.virtual_server.all
      puts c.slb.virtual_server.get('test') rescue puts 'Not Found'

      # Server
      #
      puts c.slb.server.all
      puts c.slb.server.get('test') rescue puts 'Server Not Found'




      # Class List
      #
      puts c.slb.class_list.all
      puts c.slb.class_list.delete('ClassListTest02')

      # Aflex
      #
      puts c.slb.aflex.all
      puts c.slb.aflex.get('host_switching')
      puts c.slb.aflex.get('redirect1')

      # Template
      #
      puts c.slb.template.server_ssl.all
      puts c.slb.template.cookie_persistence.all
      puts c.slb.template.src_ip_persistence.all


      ####################

      # Close session
      c.session.close
    end
  end
end