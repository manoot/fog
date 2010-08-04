require 'fog/model'

module Fog
  module Xenserver
    class Vm < Fog::Model
      # API Reference here:
      # http://docs.vmd.citrix.com/XenServer/5.6.0/1.0/en_gb/api/?c=VM
      
      identity :uuid
      
      attribute :name_label
      attribute :reference
      attribute :affinity
      attribute :allowed_operations
      attribute :blobs
      attribute :consoles
      attribute :domarch
      attribute :domid
      attribute :guest_metrics
      attribute :is_a_snapshot
      attribute :is_a_template
      attribute :is_control_domain
      attribute :memory_dynamic_max
      attribute :memory_dynamic_min
      attribute :memory_static_max
      attribute :memory_static_min
      attribute :memory_target
      attribute :metrics
      attribute :name_description
      attribute :other_config
      attribute :power_state
      attribute :PV_args
      attribute :resident_on
      attribute :VBDs
      attribute :VCPUs_at_startup
      attribute :VCPUs_max
      attribute :VIFs
      
      ignore_attributes :HVM_boot_params, :HVM_boot_policy, :HVM_shadow_multiplier, :PCI_bus, :PV_bootloader,
                        :PV_bootloader_args, :PV_kernel, :PV_legacy_args, :PV_ramdisk, :VCPUs_params, :VTPMs,
                        :actions_after_crash, :actions_after_reboot, :actions_after_shutdown, :blobs,
                        :blocked_operations, :crash_dumps, :current_operations, :ha_always_run, :ha_restart_priority,
                        :last_boot_CPU_flags, :last_booted_record, :platform, :recommendations, :snapshot_time,
                        :snapshots, :snapshot_of, :suspend_VDI, :tags, :transportable_snapshot_id, :user_version, 
                        :xenstore_data

      def initialize(attributes={})
        @uuid ||= 0
        super
      end
      
      # associations
      def networks
        @VIFs.collect {|vif| Fog::Xenserver::Vif.new(connection.get_vif_by_ref( vif ))}
      end
      
      def running_on
        Fog::Xenserver::Host.new(connection.get_host_by_ref( @resident_on ))
      end
      
      def home_hypervisor
        Fog::Xenserver::Host.new(connection.get_host_by_ref( @affinity ))
      end
      
      # shortcuts
      def mac_address
        networks.first.MAC
      end
      
      # operations
      
      # create : clones a vm from template, generates a new vif and provisions the two as a new vm instance
      def create(name_label, image, network)
        Fog::Xenserver::Vm.new(connection.create_vm(name_label, image, network))
      end
    end
    
  end
end
