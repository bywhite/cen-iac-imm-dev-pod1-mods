
# Creating servers in Intersight using Terraform Cloud for Business

This module uses the server.profile to derive Server profiles by cloning the server template
# Primary Problem - Template policies are not set in server profiles - unless tempate is manually re-updated
# Other problem with merger 
    - 
#  Advantage of Merger is:
    + Removing server profile in code removes them in Intersight - unlike clone which does not.

Module Location:
https://github.com/bywhite/cen-iac-imm-dev-pod1-mods/imm-pod-servers-vmw-cloner-mod




Error - duplicate (already exists error when re-running apply - should have no error)


│ Error: error occurred while updating ServerProfile: 403 Forbidden Response from endpoint: {"code":"InvalidRequest","message":"Cannot edit a server profile attached to a profile template","messageId":"gershwin_cannot_edit_derived_sp","messageParams":{},"traceId":"bcCQH1ZBnz3aMCVv0ix-iz9oULJyRwwkdwan3UkYL0xztvj2Z6aOpw=="}
│ 
│   with module.server_template_vmw_merger.intersight_server_profile.server_profile_list[1],
│   on .terraform/modules/server_template_vmw_merger/imm-pod-servers-vmw-merger-mod/server-profiles.tf line 84, in resource "intersight_server_profile" "server_profile_list":
│   84: resource "intersight_server_profile" "server_profile_list" {
│ 

-------------------- increasing number of servers from 2 to 3  ----------------------
│ Error: error occurred while updating ServerProfile: 403 Forbidden Response from endpoint: {"code":"InvalidRequest","message":"Cannot edit a server profile attached to a profile template","messageId":"gershwin_cannot_edit_derived_sp","messageParams":{},"traceId":"T_MEl8WnmiMP7gApQIR-BnjideK02S9ohZAy0rqJ_W9njhsxiBC-oA=="}
│ 
│   with module.server_template_vmw_basic.intersight_server_profile.server_profile_list[0],
│   on .terraform/modules/server_template_vmw_basic/imm-pod-servers-vmw-basic-mod/server-profiles.tf line 7, in resource "intersight_server_profile" "server_profile_list":
│    7: resource "intersight_server_profile" "server_profile_list" {
│ 
╵
╷
│ Error: error occurred while updating ServerProfile: 403 Forbidden Response from endpoint: {"code":"InvalidRequest","message":"Cannot edit a server profile attached to a profile template","messageId":"gershwin_cannot_edit_derived_sp","messageParams":{},"traceId":"UzXmqycMnYTwFTlToZznSb_0TlTk3OED_vQsBHASaVUwyYtUOhcemQ=="}
│ 
│   with module.server_template_vmw_basic.intersight_server_profile.server_profile_list[1],
│   on .terraform/modules/server_template_vmw_basic/imm-pod-servers-vmw-basic-mod/server-profiles.tf line 7, in resource "intersight_server_profile" "server_profile_list":
│    7: resource "intersight_server_profile" "server_profile_list" {