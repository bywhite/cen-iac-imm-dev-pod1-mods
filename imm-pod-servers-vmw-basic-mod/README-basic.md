
# Creating servers in Intersight using Terraform Cloud for Business

This module uses the server.profile to derive Server profiles by cloning the server template
# Primary Problem - you can't run the Merge against existing objects that are associated with a template
# Other problem with merger 
    - If you create 2, then change to 1, then try to go back to 2 ... It will error w/ duplicate object exists
    - Server profiles sometimes lose their template instantiated properties when adjusting counts
#  Advantage of Merger is:
    The derived server.profile's have all Policies associated, as in Profile Template and has Identities assigned
    Works correctly the first time - does not work subsequently when adjusting server count +/-
    Removing server.profile in code removes them in Intersight - unlike clone which does not. (still based on initial server profiles)

Module Location:
https://github.com/bywhite/cen-iac-imm-dev-pod1-mods/imm-pod-servers-vmw-cloner-mod




Error - duplicate (already exists error when re-running apply - should have no error)


│ Error: error occurred while updating ServerProfile: 403 Forbidden Response from endpoint: {"code":"InvalidRequest","message":"Cannot edit a server profile attached to a profile template","messageId":"gershwin_cannot_edit_derived_sp","messageParams":{},"traceId":"bcCQH1ZBnz3aMCVv0ix-iz9oULJyRwwkdwan3UkYL0xztvj2Z6aOpw=="}
│ 
│   with module.server_template_vmw_merger.intersight_server_profile.server_profile_list[1],
│   on .terraform/modules/server_template_vmw_merger/imm-pod-servers-vmw-merger-mod/server-profiles.tf line 84, in resource "intersight_server_profile" "server_profile_list":
│   84: resource "intersight_server_profile" "server_profile_list" {
│ 