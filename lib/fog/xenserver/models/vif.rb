require 'fog/model'

module Fog
  module Xenserver
    
    class Vif < Fog::Model
      # API Reference here:
      # http://docs.vmd.citrix.com/XenServer/5.6.0/1.0/en_gb/api/?c=VIF
      
      identity :reference
      
      attribute :MAC
      attribute :uuid
      attribute :allowed_operations
      attribute :currently_attached
      attribute :device
      attribute :MAC_autogenerated
      attribute :metrics
      attribute :MTU
      attribute :network
      attribute :status_code
      attribute :status_detail
      attribute :VM
      
      ignore_attributes :current_operations, :qos_supported_algorithms, :qos_algorithm_params, :qos_algorithm_type, :other_config,
                        :runtime_properties
      
      def initialize(attributes={})
        @uuid ||= 0
        super
      end
    end
    
  end
end