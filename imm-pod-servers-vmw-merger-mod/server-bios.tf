# =============================================================================
# Server BIOS Policies for FI-Attached server template
# -----------------------------------------------------------------------------
# Reference: https://registry.terraform.io/providers/CiscoDevNet/Intersight/latest/docs/resources/bios_policy

resource "intersight_bios_policy" "bios_policy1" {
  name            = "${var.server_policy_prefix}-bios-policy1"
  description     = var.description
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }

  acs_control_gpu1state                 = "disabled"
  acs_control_gpu2state                 = "disabled"
  acs_control_gpu3state                 = "disabled"
  acs_control_gpu4state                 = "disabled"
  acs_control_gpu5state                 = "disabled"
  acs_control_gpu6state                 = "disabled"
  acs_control_gpu7state                 = "disabled"
  acs_control_gpu8state                 = "disabled"
  acs_control_slot11state               = "disabled"
  acs_control_slot12state               = "disabled"
  acs_control_slot13state               = "disabled"
  acs_control_slot14state               = "disabled"
  cdn_support                           = "disabled"
  lom_port0state                        = "disabled"
  lom_port1state                        = "disabled"
  lom_port2state                        = "disabled"
  lom_port3state                        = "disabled"
  lom_ports_all_state                   = "disabled"
  pci_option_ro_ms                      = "disabled"
  pci_rom_clp                           = "disabled"
  slot10link_speed                      = "Auto"
  slot10state                           = "disabled"
  slot11link_speed                      = "Auto"
  slot11state                           = "disabled"
  slot12link_speed                      = "Auto"
  slot12state                           = "disabled"
  slot13state                           = "disabled"
  slot14state                           = "disabled"
  slot1link_speed                       = "Auto"
  slot1state                            = "disabled"
  slot2link_speed                       = "Auto"
  slot2state                            = "disabled"
  slot3link_speed                       = "GEN3"
  slot3state                            = "disabled"
  slot4link_speed                       = "Auto"
  slot4state                            = "disabled"
  slot5link_speed                       = "GEN2"
  slot5state                            = "disabled"
  slot6link_speed                       = "Auto"
  slot6state                            = "disabled"
  slot7link_speed                       = "GEN1"
  slot7state                            = "disabled"
  slot8link_speed                       = "Auto"
  slot8state                            = "disabled"
  slot9link_speed                       = "Auto"
  slot9state                            = "disabled"
  slot_flom_link_speed                  = "Auto"
  slot_front_nvme1link_speed            = "Auto"
  slot_front_nvme2link_speed            = "Auto"
  slot_front_slot5link_speed            = "Auto"
  slot_front_slot6link_speed            = "Auto"
  slot_gpu1state                        = "disabled"
  slot_gpu2state                        = "disabled"
  slot_gpu3state                        = "disabled"
  slot_gpu4state                        = "disabled"
  slot_gpu5state                        = "disabled"
  slot_gpu6state                        = "disabled"
  slot_gpu7state                        = "disabled"
  slot_gpu8state                        = "disabled"
  slot_hba_link_speed                   = "Auto"
  slot_hba_state                        = "disabled"
  slot_lom1link                         = "disabled"
  slot_lom2link                         = "disabled"
  slot_mezz_state                       = "disabled"
  slot_mlom_link_speed                  = "Auto"
  slot_mlom_state                       = "disabled"
  slot_mraid_link_speed                 = "Auto"
  slot_mraid_state                      = "disabled"
  slot_n10state                         = "disabled"
  slot_n11state                         = "disabled"
  slot_n12state                         = "disabled"
  slot_n13state                         = "disabled"
  slot_n14state                         = "disabled"
  slot_n15state                         = "disabled"
  slot_n16state                         = "disabled"
  slot_n17state                         = "disabled"
  slot_n18state                         = "disabled"
  slot_n19state                         = "disabled"
  slot_n1state                          = "disabled"
  slot_n20state                         = "disabled"
  slot_n21state                         = "disabled"
  slot_n22state                         = "disabled"
  slot_n23state                         = "disabled"
  slot_n24state                         = "disabled"
  slot_n2state                          = "disabled"
  slot_n3state                          = "disabled"
  slot_n4state                          = "disabled"
  slot_n5state                          = "disabled"
  slot_n6state                          = "disabled"
  slot_n7state                          = "disabled"
  slot_n8state                          = "disabled"
  slot_n9state                          = "disabled"
  slot_raid_link_speed                  = "Auto"
  slot_raid_state                       = "disabled"
  slot_rear_nvme1link_speed             = "Auto"
  slot_rear_nvme1state                  = "disabled"
  slot_rear_nvme2link_speed             = "Auto"
  slot_rear_nvme2state                  = "disabled"
  slot_rear_nvme3state                  = "disabled"
  slot_rear_nvme4state                  = "disabled"
  slot_rear_nvme5state                  = "disabled"
  slot_rear_nvme6state                  = "disabled"
  slot_rear_nvme7state                  = "disabled"
  slot_rear_nvme8state                  = "disabled"
  slot_riser1link_speed                 = "Auto"
  slot_riser1slot1link_speed            = "Auto"
  slot_riser1slot2link_speed            = "Auto"
  slot_riser1slot3link_speed            = "Auto"
  slot_riser2link_speed                 = "Auto"
  slot_riser2slot4link_speed            = "Auto"
  slot_riser2slot5link_speed            = "Auto"
  slot_riser2slot6link_speed            = "Auto"
  slot_sas_state                        = "disabled"
  slot_ssd_slot1link_speed              = "Auto"
  slot_ssd_slot2link_speed              = "Auto"
  adjacent_cache_line_prefetch          = "disabled"
  altitude                              = "300-m"
  auto_cc_state                         = "disabled"
  autonumous_cstate_enable              = "disabled"
  boot_performance_mode                 = "Max Performance"
  cbs_cmn_cpu_gen_downcore_ctrl         = "FOUR (2 + 2)"
  channel_inter_leave                   = "auto"
  closed_loop_therm_throtl              = "disabled"
  cmci_enable                           = "disabled"
  config_tdp                            = "disabled"
  core_multi_processing                 = "2"
  cpu_energy_performance                = "performance"
  cpu_frequency_floor                   = "disabled"
  cpu_performance                       = "custom"
  cpu_power_management                  = "custom"
  demand_scrub                          = "disabled"
  direct_cache_access                   = "disabled"
  dram_clock_throttling                 = "Auto"
  energy_efficient_turbo                = "disabled"
  eng_perf_tuning                       = "OS"
  enhanced_intel_speed_step_tech        = "disabled"
  epp_profile                           = "Power"
  execute_disable_bit                   = "disabled"
  extended_apic                         = "disabled"
  hardware_prefetch                     = "disabled"
  hwpm_enable                           = "HWPM Native Mode"
  imc_interleave                        = "1-way Interleave"
  intel_hyper_threading_tech            = "disabled"
  intel_speed_select                    = "Base"
  intel_turbo_boost_tech                = "disabled"
  intel_virtualization_technology       = "disabled"
  ioh_error_enable                      = "Yes"
  ip_prefetch                           = "disabled"
  kti_prefetch                          = "disabled"
  llc_prefetch                          = "disabled"
  memory_inter_leave                    = "disabled"
  package_cstate_limit                  = "Auto"
  patrol_scrub                          = "disabled"
  patrol_scrub_duration                 = "platform-default"
  pc_ie_ssd_hot_plug_support            = "disabled"
  processor_c1e                         = "disabled"
  processor_c3report                    = "disabled"
  processor_c6report                    = "disabled"
  processor_cstate                      = "disabled"
  pstate_coord_type                     = "HW ALL"
  pwr_perf_tuning                       = "bios"
  rank_inter_leave                      = "auto"
  single_pctl_enable                    = "Yes"
  smt_mode                              = "Auto"
  snc                                   = "disabled"
  streamer_prefetch                     = "disabled"
  svm_mode                              = "disabled"
  work_load_config                      = "Balanced"
  xpt_prefetch                          = "Auto"
  all_usb_devices                       = "disabled"
  legacy_usb_support                    = "disabled"
  make_device_non_bootable              = "disabled"
  pch_usb30mode                         = "disabled"
  usb_emul6064                          = "disabled"
  usb_port_front                        = "disabled"
  usb_port_internal                     = "disabled"
  usb_port_kvm                          = "disabled"
  usb_port_rear                         = "disabled"
  usb_port_sd_card                      = "disabled"
  usb_port_vmedia                       = "disabled"
  usb_xhci_support                      = "disabled"
  aspm_support                          = "Auto"
  ioh_resource                          = "IOH0 24k IOH1 40k"
  memory_mapped_io_above4gb             = "disabled"
  mmcfg_base                            = "2 GB"
  onboard10gbit_lom                     = "disabled"
  onboard_gbit_lom                      = "disabled"
  sr_iov                                = "disabled"
  vga_priority                          = "Onboard"
  assert_nmi_on_perr                    = "disabled"
  assert_nmi_on_serr                    = "disabled"
  baud_rate                             = "115200"
  cdn_enable                            = "disabled"
  cisco_adaptive_mem_training           = "disabled"
  cisco_debug_level                     = "Minimum"
  cisco_oprom_launch_optimization       = "disabled"
  console_redirection                   = "disabled"
  flow_control                          = "rts-cts"
  frb2enable                            = "disabled"
  legacy_os_redirection                 = "disabled"
  os_boot_watchdog_timer                = "disabled"
  os_boot_watchdog_timer_policy         = "power-off"
  os_boot_watchdog_timer_timeout        = "15-minutes"
  out_of_band_mgmt_port                 = "disabled"
  putty_key_pad                         = "LINUX"
  redirection_after_post                = "Always Enable"
  terminal_type                         = "vt100"
  ucsm_boot_order_rule                  = "Loose"
  bme_dma_mitigation                    = "disabled"
  cbs_cmn_gnb_nb_iommu                  = "disabled"
  cbs_cmn_mem_ctrl_bank_group_swap_ddr4 = "disabled"
  cbs_cmn_mem_map_bank_interleave_ddr4  = "Auto"
  cbs_df_cmn_mem_intlv                  = "Auto"
  cbs_df_cmn_mem_intlv_size             = "Auto"
  dcpmm_firmware_downgrade              = "disabled"
  smee                                  = "disabled"
  boot_option_num_retry                 = "13"
  boot_option_re_cool_down              = "90"
  boot_option_retry                     = "disabled"
  ipv6pxe                               = "disabled"
  onboard_scu_storage_support           = "disabled"
  onboard_scu_storage_sw_stack          = "Intel RSTe"
  pop_support                           = "disabled"
  psata                                 = "AHCI"
  sata_mode_select                      = "AHCI"
  vmd_enable                            = "disabled"
  cbs_cmn_cpu_cpb                       = "Auto"
  cbs_cmn_cpu_global_cstate_ctrl        = "Auto"
  cbs_cmn_cpu_l1stream_hw_prefetcher    = "Auto"
  cbs_cmn_cpu_l2stream_hw_prefetcher    = "Auto"
  cbs_cmn_determinism_slider            = "Auto"
  cbs_cmnc_tdp_ctl                      = "Auto"
  cke_low_policy                        = "auto"
  dram_refresh_rate                     = "2x"
  lv_ddr_mode                           = "auto"
  mirroring_mode                        = "inter-socket"
  numa_optimized                        = "disabled"
  select_memory_ras_configuration       = "mirror-mode-1lm"
  sparing_mode                          = "dimm-sparing"
  intel_vt_for_directed_io              = "disabled"
  intel_vtd_coherency_support           = "disabled"
  intel_vtd_interrupt_remapping         = "disabled"
  intel_vtd_pass_through_dma_support    = "disabled"
  intel_vtdats_support                  = "disabled"
  post_error_pause                      = "disabled"
  tpm_support                           = "disabled"
  qpi_link_frequency                    = "7.2-gt/s"
  qpi_snoop_mode                        = "auto"
  serial_port_aenable                   = "disabled"
  tpm_control                           = "disabled"
  txt_support                           = "disabled"
}
