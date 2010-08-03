module Fog
  module Xenserver
    class Real
      
      require 'fog/xenserver/parser'
      
      def get_vm( name_label )
        vm_ref = @connection.request({:parser => Fog::Parsers::Xenserver::Base.new, :method => 'VM.get_by_name_label'}, name_label)
        @connection.request({:parser => Fog::Parsers::Xenserver::Base.new, :method => 'VM.get_record'}, vm_ref)
      end
      
    end
    
    class Mock
      
      def get_vm( uuid )
        Fog::Mock.not_implemented
      end
      
    end
  end
end
