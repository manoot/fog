require 'fog/model'

module Fog
  module Xenserver

    class Network < Fog::Model
      # API Reference here:
      # http://docs.vmd.citrix.com/XenServer/5.6.0/1.0/en_gb/api/?c=network
      
      identity :reference
      
      attribute :name_label
      attribute :uuid
      attribute :bridge
      attribute :name_description
      attribute :other_config
      attribute :PIFs
      attribute :VIFs
      
      ignore_attributes :allowed_operations, :blobs, :collection, :current_operations, :tags, :MTU
      
      def initialize(attributes={})
        @uuid ||= 0
        super
      end
      
    end
    
  end
end
