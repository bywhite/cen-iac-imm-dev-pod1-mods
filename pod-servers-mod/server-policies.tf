# Policies needed for Server Configurations


# =============================================================================
# Multicast
# -----------------------------------------------------------------------------

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy1" {
  name               = "${var.policy_prefix}-multicast-policy-1"
  description        = var.description
  querier_ip_address = ""
  querier_state      = "Disabled"
  snooping_state     = "Enabled"
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


# =============================================================================
# Virtual KVM Policy
# -----------------------------------------------------------------------------

resource "intersight_kvm_policy" "kvmpolicy-1" {
  name                      = "${var.policy_prefix}-kvm-enabled-policy-1"
  description               = var.description
  enable_local_server_video = true
  enable_video_encryption   = true
  enabled                   = true
  maximum_sessions          = 4
  organization {
    moid = var.organization
  }
  remote_port = 2068
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


# =============================================================================
# Virtual Media Policy
# -----------------------------------------------------------------------------
/**
resource "intersight_vmedia_policy" "vmedia1" {
  name          = "${var.policy_prefix}-vmedia-ubuntu-policy-1"
  description   = var.description
  enabled       = true
  encryption    = false
  low_power_usb = true
  mappings = [{
    additional_properties   = ""
    authentication_protocol = "none"
    class_id                = "vmedia.Mapping"
    device_type             = "cdd"
    file_location           = "infra-chx.auslab.cisco.com/software/linux/ubuntu-18.04.5-server-amd64.iso"
    host_name               = "infra-chx.auslab.cisco.com"
    is_password_set         = false
    mount_options           = "RO"
    mount_protocol          = "nfs"
    object_type             = "vmedia.Mapping"
    password                = ""
    remote_file             = "ubuntu-18.04.5-server-amd64.iso"
    remote_path             = "/iso/software/linux"
    sanitized_file_location = "infra-chx.auslab.cisco.com/software/linux/ubuntu-18.04.5-server-amd64.iso"
    username                = ""
    volume_name             = "IMC_DVD"
  }]
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
**/
/**
resource "intersight_vmedia_policy" "vmedia2" {
  name          = "${var.policy_prefix}-vmedia-enabled-policy-1"
  description   = var.description
  enabled       = true
  encryption    = true
  low_power_usb = true
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
**/

# =============================================================================
# IMC Access
# -----------------------------------------------------------------------------

resource "intersight_access_policy" "access1" {
  name        = "${var.policy_prefix}-imc-access-policy-1"
  description = var.description
  inband_vlan = var.imc_access_vlan
  inband_ip_pool {
    object_type  = "ippool.Pool"
    #moid        = intersight_ippool_pool.ippool_pool1.moid
    moid         = var.imc_ip_pool_moid
  }
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}

=============================================================================
Serial Over LAN (optional)
-----------------------------------------------------------------------------

resource "intersight_sol_policy" "sol1" {
 name        = "${var.policy_prefix}-sol-off-policy-1"
 description = var.description
 enabled     = false
 baud_rate   = 9600
 com_port    = "com1"
 ssh_port    = 1096
 organization {
   moid        = var.organization
   object_type = "organization.Organization"
 }
 dynamic "tags" {
   for_each = var.tags
   content {
     key   = tags.value.key
     value = tags.value.value
   }
 }
}


=============================================================================
IPMI over LAN (optional)   Used by Server Profile Template
-----------------------------------------------------------------------------

resource "intersight_ipmioverlan_policy" "ipmi1" {
 description = var.description
 enabled     = false
 name        = "${var.policy_prefix}-ipmi-disabled"
 organization {
   moid        = var.organization
   object_type = "organization.Organization"
 }
 dynamic "tags" {
   for_each = var.tags
   content {
     key   = tags.value.key
     value = tags.value.value
   }
 }
}


# =============================================================================
# Boot Precision (boot order) Policy
# -----------------------------------------------------------------------------

resource "intersight_boot_precision_policy" "boot_precision_1" {
  name                     = "${var.policy_prefix}-vmw-boot-order-policy-1"
  description              = var.description
  configured_boot_mode     = "Uefi"
  enforce_uefi_secure_boot = false
#  boot_devices {
#    enabled     = true
#    name        = "KVM_DVD"
#    object_type = "boot.VirtualMedia"
#    additional_properties = jsonencode({
#      Subtype = "kvm-mapped-dvd"
#    })
#  }
#  boot_devices {
#    enabled     = true
#    name        = "IMC_DVD"
#    object_type = "boot.VirtualMedia"
#    additional_properties = jsonencode({
#      Subtype = "cimc-mapped-dvd"
#    })
#  }
  boot_devices {
    enabled     = true
    name        = "LocalDisk"
    object_type = "boot.LocalDisk"
  }
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


=============================================================================
Device Connector Policy (optional)
-----------------------------------------------------------------------------

resource "intersight_deviceconnector_policy" "deviceconnector1" {
 description     = var.description
 lockout_enabled = true
 name            = "${var.policy_prefix}-device-connector"
 organization {
   moid        = var.organization
   object_type = "organization.Organization"
 }
 dynamic "tags" {
   for_each = var.tags
   content {
     key   = tags.value.key
     value = tags.value.value
   }
 }
}


