# Policies needed for Server Configurations


# =============================================================================
# Multicast
# -----------------------------------------------------------------------------

resource "intersight_fabric_multicast_policy" "fabric_multicast_policy_1" {
  name               = "${var.server_policy_prefix}-multicast-policy-1"
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

resource "intersight_kvm_policy" "kvmpolicy_1" {
  name                      = "${var.server_policy_prefix}-kvm-enabled-policy-1"
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
  name          = "${var.server_policy_prefix}-vmedia-ubuntu-policy-1"
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
  name          = "${var.server_policy_prefix}-vmedia-enabled-policy-1"
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

resource "intersight_access_policy" "access_1" {
  name        = "${var.server_policy_prefix}-imc-access-policy-1"
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

# =============================================================================
# Serial Over LAN (optional)
# -----------------------------------------------------------------------------

# resource "intersight_sol_policy" "sol1" {
#  name        = "${var.server_policy_prefix}-sol-off-policy-1"
#  description = var.description
#  enabled     = false
#  baud_rate   = 9600
#  com_port    = "com1"
#  ssh_port    = 1096
#  organization {
#    moid        = var.organization
#    object_type = "organization.Organization"
#  }
#  dynamic "tags" {
#    for_each = var.tags
#    content {
#      key   = tags.value.key
#      value = tags.value.value
#    }
#  }
# }


# =============================================================================
# IPMI over LAN (optional)   Used by Server Profile Template
# -----------------------------------------------------------------------------

# resource "intersight_ipmioverlan_policy" "ipmi1" {
#  description = var.description
#  enabled     = false
#  name        = "${var.server_policy_prefix}-ipmi-disabled"
#  organization {
#    moid        = var.organization
#    object_type = "organization.Organization"
#  }
#  dynamic "tags" {
#    for_each = var.tags
#    content {
#      key   = tags.value.key
#      value = tags.value.value
#    }
#  }
# }


# =============================================================================
# Boot Precision - Creates "Boot Order Policy"
# Examples: https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/examples/policies/boot_order_policies.tf
# -----------------------------------------------------------------------------

resource "intersight_boot_precision_policy" "boot_precision_1" {
  name                     = "${var.server_policy_prefix}-vmw-boot-order-policy-1"
  description              = var.description
  configured_boot_mode     = "Uefi"
  enforce_uefi_secure_boot = false
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }

 boot_devices {
   enabled     = true
   name        = "KVM_DVD"
   object_type = "boot.VirtualMedia"
    additional_properties = jsonencode({
      Subtype = "kvm-mapped-dvd"
    })
 }

 boot_devices {
   enabled     = true
   name        = "IMC_DVD"
   object_type = "boot.VirtualMedia"
   additional_properties = jsonencode({
     Subtype = "cimc-mapped-dvd"
   })
 }

 boot_devices {
   enabled         = true
   name            = "PXE-eth0"
   object_type     = "boot.Pxe"
   additional_properties = jsonencode({
      interfacesource = "name"
      interfacename   = "eth0"  # use if interfacesource is "name"
      iptype          = "IPv4"
      slot            = "MLOM"
      #port           = "-1"    # use if interfacesource is "port"
      #MacAddress     = ""      # use if interfacesource is "mac"
   })
}

  boot_devices {
    enabled     = true
    name        = "M2-RAID"
    object_type = "boot.LocalDisk"
       additional_properties = jsonencode({
        slot        = "MSTOR-RAID"
   })

  }


    boot_devices {
    enabled     = true
    name        = "LocalDisk"
    object_type = "boot.LocalDisk"
  }


  boot_devices {
    enabled     = true
    name        = "interfacename"
    object_type = "boot.San"
      additional_properties = jsonencode({
        Bootloader = {
            ClassId     = "boot.Bootloader"
            Description = "rhel",
            Name        = "bootx64.efi",
            ObjectType  = "boot.Bootloader"
            Path        = "\\EFI\\BOOT\\BOOTx64.EFI"
          }
        InterfaceName = "fc0"
        Lun           = 0
        Slot          = "MLOM"
        Wwpn          = "20:00:00:25:B5:00:01:ff"
      })
  }

## example from tf-int-imm module
# module "boot_legacy_san" {
#   depends_on = [
#     data.intersight_organization_organization.org_moid
#   ]
#   source      = "terraform-cisco-modules/imm/intersight//modules/boot_order_policies"
#   boot_mode   = "Legacy"
#   description = "Legacy SAN Boot Example."
#   name        = "example_legacy_san"
#   org_moid    = local.org_moid
#   profiles    = []
#   tags        = var.tags
#   boot_devices = [
#     {
#       additional_properties = jsonencode(
#         {
#           InterfaceName = "vHBA-A",
#           Lun           = 0,
#           Slot          = "MLOM",
#           Wwpn          = "20:00:00:25:B5:00:01:ff"
#         }
#       )
#       enabled     = true,
#       name        = "SAN_A_Boot",
#       object_type = "boot.San",
#     },
#   ]
# }

  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}


# =============================================================================
# Device Connector Policy (optional)
# -----------------------------------------------------------------------------

resource "intersight_deviceconnector_policy" "deviceconnector1" {
 description     = var.description
 lockout_enabled = true
 name            = "${var.server_policy_prefix}-device-connector"
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


