# =============================================================================
# Network Related Server Policies
# -----------------------------------------------------------------------------



# # =============================================================================
# # Intersight Adapter Configuration Policy  ** Doesn't appear in Server Template
# # -----------------------------------------------------------------------------
# resource "intersight_adapter_config_policy" "adapter_config1" {
#   name        = "adapter_config1"
#   description = "example policy"
#   organization {
#     object_type = "organization.Organization"
#     moid        = var.organization
#   }
# #   settings {
# #     object_type = "adapter.AdapterConfig"
# #     slot_id     = "1"
# #     eth_settings {
# #       lldp_enabled = true
# #       object_type  = "adapter.EthSettings"
# #     }
# #     fc_settings {
# #       object_type = "adapter.FcSettings"
# #       fip_enabled = true
# #     }
# #   }
#   settings {
#     object_type = "adapter.AdapterConfig"
#     slot_id     = "MLOM"
#     eth_settings {
#       object_type  = "adapter.EthSettings"
#       lldp_enabled = true
#     }
#     fc_settings {
#       object_type = "adapter.FcSettings"
#       fip_enabled = true
#     }
#   }
#   profiles {
#     moid        = server.moid
#     object_type = "server.Profile"
#   }
# }




# =============================================================================
# 
# -----------------------------------------------------------------------------




# =============================================================================
# 
# -----------------------------------------------------------------------------




# =============================================================================
# 
# -----------------------------------------------------------------------------




# =============================================================================
# 
# -----------------------------------------------------------------------------


