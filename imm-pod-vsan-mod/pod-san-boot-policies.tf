# =============================================================================
# Server Precision Boot Order Policies for FI-Attached server template
# Creates "Boot Order Policy"
# Examples: https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/examples/policies/boot_order_policies.tf
# -----------------------------------------------------------------------------


resource "intersight_boot_precision_policy" "san_boot_policies" {
  for_each = var.san_boot_policies
  # Usage: for_each var.san_boot_policies  each.value["int_name_1"]  each.value["boot_lun_1"]  each.value["target_wwpn_1"]
  name                     = "${var.pod_policy_prefix}-san-${each.key}"
  description              = "${var.pod_policy_prefix} SAN Boot Policies"
  configured_boot_mode     = "Uefi"
  enforce_uefi_secure_boot = false
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
    name        = each.value["int_name_1"] 
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = each.value["int_name_1"] 
      Lun           = each.value["boot_lun_1"] 
      Wwpn          = each.value["target_wwpn_1"] 
    })
  }

  boot_devices {
    enabled     = true
    name        = each.value["int_name_2"] 
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = each.value["int_name_2"] 
      Lun           = each.value["boot_lun_2"] 
      Wwpn          = each.value["target_wwpn_2"] 
    })
  }

  boot_devices {
    enabled     = true
    name        = each.value["int_name_3"] 
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = each.value["int_name_3"] 
      Lun           = each.value["boot_lun_3"] 
      Wwpn          = each.value["target_wwpn_3"] 
    })
  }

  boot_devices {
    enabled     = true
    name        = each.value["int_name_4"] 
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = each.value["int_name_4"] 
      Lun           = each.value["boot_lun_4"] 
      Wwpn          = each.value["target_wwpn_4"] 
    })
  }


  # boot_devices {
  #   enabled     = true
  #   name        = "IMC_DVD"
  #   object_type = "boot.VirtualMedia"
  #   additional_properties = jsonencode({
  #     Subtype = "cimc-mapped-dvd"
  #   })
  # }

  # boot_devices {
  #   enabled     = true
  #   name        = "M2_Boot"
  #   object_type = "boot.LocalDisk"
  #   additional_properties = jsonencode({
  #     Slot    = "MSTOR-RAID"
  #     Bootloader = {
  #       Description = "M2 Boot"
  #       Name        = "BOOTX64.EFI"
  #       ObjectType  = "boot.Bootloader"
  #       Path        = "\\EFI\\BOOT\\"
  #     }
  #   })
  # }

  # boot_devices {
  #   enabled     = true
  #   name        = "RAID_Boot"
  #   object_type = "boot.LocalDisk"
  #   additional_properties = jsonencode({
  #     Slot       = "MRAID"
  #     Bootloader = {
  #       Description = "RAID Boot"
  #       Name        = "BOOTX64.EFI"
  #       ObjectType  = "boot.Bootloader"
  #       Path        = "\\EFI\\BOOT\\"
  #     }
  #   })
  # }

  # boot_devices {
  #   enabled         = true
  #   name            = "PXE"
  #   object_type     = "boot.Pxe"
  #   additional_properties = jsonencode({
  #     Slot            = "MLOM"
  #     InterfaceSource = "name"
  #     InterfaceName   = "eth0"
  #     IpType          = "IPv4"
  #   })
  
  }
