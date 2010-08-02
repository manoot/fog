require 'fog/collection'
require 'fog/xenserver/models/host'

module Fog
  module Xenserver
    
    module Collections
      def hosts
        Fog::Xenserver::Hosts.new(:connection => self)
      end
    end
    
    class Hosts < Fog::Collection
      
      model Fog::Xenserver::Host
      
      def all
        data = connection.get_hosts
        load(data)
      end
      
      def get( host_name )
        if host_name && host = connection.get_vm( host_name )
          new(host)
        end
      rescue Fog::Xenserver::NotFound
        nil
      end
      
    end
    
  end
end
