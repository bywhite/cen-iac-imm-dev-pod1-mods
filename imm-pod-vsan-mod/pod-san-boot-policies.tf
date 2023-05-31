# =============================================================================
# Server Precision Boot Order Policies for FI-Attached server template
# Creates "Boot Order Policy"
# Examples: https://github.com/terraform-cisco-modules/terraform-intersight-imm/blob/master/examples/policies/boot_order_policies.tf
# -----------------------------------------------------------------------------

resource "intersight_boot_precision_policy" "san_boot_policies" {
  name                     = "${var.pod_policy_prefix}-san-boot"
  description              = "${var.pod_policy_prefix} SAN Boot Policies"
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
    name        = "fc0"
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = "fc0"
      Lun           = 0
      Wwpn          = "50:0A:09:82:89:0B:9B:0A"
    })
  }

  boot_devices {
    enabled     = true
    name        = "fc1"
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = "fc1"
      Lun           = 0
      Wwpn          = "50:0A:09:82:89:0B:9B:0B"
    })
  }

    boot_devices {
    enabled     = true
    name        = "fc2"
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = "fc2"
      Lun           = 0
      Wwpn          = "50:0A:09:82:89:0B:9B:0C"
    })
  }

  boot_devices {
    enabled     = true
    name        = "fc3"
    object_type = "boot.San"
    additional_properties = jsonencode({
      Slot          = "MLOM"
      InterfaceName = "fc3"
      Lun           = 0
      Wwpn          = "50:0A:09:82:89:0B:9B:0D"
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
