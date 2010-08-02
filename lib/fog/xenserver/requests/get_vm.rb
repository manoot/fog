module Fog
  module Xenserver
    class Real

      require 'fog/xenserver/parsers/get_vm'

      def get_vm( name_label )
        vm = @connection.request({:parser => Fog::Parsers::Xenserver::GetVm.new, :method => 'VM.get_by_name_label'}, name_label)
        @connection.request({:parser => Fog::Parsers::Xenserver::GetVm.new, :method => 'VM.get_record'}, vm)
      end
      
    end
    
    class Mock
      
      def get_vm( uuid )
        Fog::Mock.not_implemented
      end
      
    end
  end
end
