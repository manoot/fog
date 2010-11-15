module Fog
  module Xenserver
    class Real
      
      def create_vm( name_label, image = nil, network = nil )
        image   ||= default_image
        network ||= default_network
        
        begin
          raise Fog::Xenserver::OperationUnallowed unless image.allowed_operations.include?('clone')
          @connection.request({:parser => Fog::Parsers::Xenserver::Base.new, :method => 'VM.clone'}, image.reference, name_label)
          new_vm = Fog::Xenserver::Vm.new(get_vm( name_label ))
          create_vif( new_vm.reference, network.reference )
          
         # raise Fog::Xenserver::OperationFailed unless new_vm.allowed_operations.include?('provision')
          @connection.request({:parser => Fog::Parsers::Xenserver::Base.new, :method => 'VM.provision'}, new_vm.reference)
          start_vm( new_vm.reference )
          
          new_vm
        end
      end
      
    end
    
    class Mock
      
      def create_vm()
        Fog::Mock.not_implemented
      end
      
    end
  end
end
