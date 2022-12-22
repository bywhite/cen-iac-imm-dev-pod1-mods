# This module creates the following QoS policies:
#    - Intersight Fabric System QoS Policy (Cos)
#    - Individual Intersight vnic eth QoS Policies (Best Effort, Bronze, Silver, Gold)
#        - vnic QoS should match settings of Fabric QoS per Class enabled


# =============================================================================
# Pod FI and Server Related QoS Policies
#  - System QoS Policy to define enabled Classes of Service (CoS)
#  - vNic QoS Policies for each class of service
# -----------------------------------------------------------------------------


# Create a System CoS object for consumption by FI-A and FI-B Switch Profiles
# Adjust QoS settings below to match your network environment settings
# Be sure to Comment/Un-comment & change the Individual vnic_qos policies at bottom to match CoS
resource "intersight_fabric_system_qos_policy" "system_qos1" {
  name        = "${var.policy_prefix}-qos-policy1"
  description = "Common QoS - CoS Definition for ${var.policy_prefix}"
  organization {
    moid        = var.org_id
    object_type = "organization.Organization"
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 14  # Optional
    weight             = 5
    cos                = 255
    mtu                = 1500
    multicast_optimize = false
    name               = "Best Effort"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 20   # Optional
    weight             = 7     
    cos                = 1
    mtu                = 1500
    multicast_optimize = false
    name               = "Bronze"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"  
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 23    # Optional
    weight             = 8
    cos                = 2
    mtu                = 1500
    multicast_optimize = false
    name               = "Silver"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  # Class of Service 3 is used for FibreChannel (fcoe)
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 14     # Optional
    weight             = 5
    cos                = 3
    mtu                = 2240
    multicast_optimize = false
    name               = "FC"
    packet_drop        = false
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  classes {
    admin_state        = "Enabled"
    bandwidth_percent  = 29     # Optional
    weight             = 9
    cos                = 4
    mtu                = 9216
    multicast_optimize = false
    name               = "Gold"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
  classes {
    admin_state        = "Disabled"
    # bandwidth_percent  = 0      # Optional
    weight             = 10
    cos                = 5
    mtu                = 9216
    multicast_optimize = false
    name               = "Platinum"
    packet_drop        = true
    class_id           = "fabric.QosClass"
    object_type        = "fabric.QosClass"    
  }
}


resource "intersight_vnic_eth_qos_policy" "vnic_qos_besteffort" {
  name           = "${var.policy_prefix}-qos-besteffort"
  description    = "Pod QoS policy Best-Effort"
  mtu            = 1500
  rate_limit     = 0
  cos            = 0
  burst          = 1024
  priority       = "Best Effort"
  trust_host_cos = false
  organization {
    moid = var.org_id
  }
}

resource "intersight_vnic_eth_qos_policy" "vnic_qos_bronze" {
  name           = "${var.policy_prefix}-qos-bronze"
  description    = "Pod QoS policy Bronze"
  mtu            = 1500
  rate_limit     = 0
  cos            = 1
  burst          = 1024
  priority       = "Bronze"
  trust_host_cos = false
  organization {
    moid = var.org_id
  }
}

resource "intersight_vnic_eth_qos_policy" "vnic_qos_silver" {
  name           = "${var.policy_prefix}-qos-silver"
  description    = "Pod QoS policy Silver"
  mtu            = 9000       # Max value 9000
  rate_limit     = 0
  cos            = 2
  burst          = 1024
  priority       = "Silver"
  trust_host_cos = false
  organization {
    moid = var.org_id
  }
}

resource "intersight_vnic_eth_qos_policy" "vnic_qos_gold" {
  name           = "${var.policy_prefix}-qos-gold"
  description    = "Pod QoS policy Gold"
  mtu            = 9000       # Max value 9000
  rate_limit     = 0
  cos            = 4
  burst          = 1024
  priority       = "Gold"
  trust_host_cos = false
  organization {
    moid = var.org_id
  }
}

# Un-Comment and Enable when added to CoS above
# resource "intersight_vnic_eth_qos_policy" "vnic_qos_platinum" {
#   name           = "${var.policy_prefix}-qos-platinum"
#   description    = "Pod QoS policy Platinum"
#   mtu            = 9000       # Max value 9000
#   rate_limit     = 0
#   cos            = 5
#   burst          = 1024
#   priority       = "Platinum"
#   trust_host_cos = false
#   organization {
#     moid = var.org_id
#   }
# }


resource "intersight_vnic_fc_qos_policy" "vnic_qos_fc" {
  name                = "${var.policy_prefix}-qos-fc"
  description         = "Pod QoS policy for FC"
  burst               = 10240
  rate_limit          = 0
  cos                 = 3
  max_data_field_size = 2112
  organization {
    object_type = "organization.Organization"
    moid        = var.org_id
  }
}
