module Fog
  module Xenserver
    class Real
      
      require 'fog/xenserver/parsers/get_hosts'
      
      def get_hosts( options = {} )
        options[:sort] ||= 'name_label'
        result = @connection.request(:parser => Fog::Parsers::Xenserver::GetHosts.new, :method => 'host.get_all_records')
        result.sort! {|a,b| a[ options[:sort].to_sym ] <=> b[ options[:sort].to_sym ]}
      end
      
    end
    
    class Mock
      
      def get_hosts
        Fog::Mock.not_implemented
      end
      
    end
  end
end
