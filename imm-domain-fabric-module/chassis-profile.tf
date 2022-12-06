#  Chassis Profile Creation

resource "intersight_chassis_profile" "chassis_profile1" {
  name            = "chassis_profile1"
  description     = "chassis profile"
  type            = "instance"
  target_platform = "FIAttached"
  action          = "Validate"
  config_context {
    object_type    = "policy.ConfigContext"
    control_action = "deploy"
    error_state    = "Validation-error"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }

# IMC Access Policy Required:  In-Band VLAN-ID, IP-Pool
# Chassis Power Policy recommended: 
#        Power Save Mode, Dynamic Power Rebalancing, Extended Power, Power Allocation:0
# SNMP Policy optional
# Thermal Policy optional:  Fan Control Mode: Balanced



#      "PolicyBucket": [
        # {
        #   "ClassId": "mo.MoRef",
        #   "Moid": "638f5b836275722d306a23e3",
        #   "ObjectType": "access.Policy",
        #   "link": "https://www.intersight.com/api/v1/access/Policies/638f5b836275722d306a23e3"
        # },
        # {
        #   "ClassId": "mo.MoRef",
        #   "Moid": "638f5c646275722d306a3c01",
        #   "ObjectType": "power.Policy",
        #   "link": "https://www.intersight.com/api/v1/power/Policies/638f5c646275722d306a3c01"
        # },
        # {
        #   "ClassId": "mo.MoRef",
        #   "Moid": "638f5de36275722d306a6177",
        #   "ObjectType": "thermal.Policy",
        #   "link": "https://www.intersight.com/api/v1/thermal/Policies/638f5de36275722d306a6177"
        # },
        # {
        #   "ClassId": "mo.MoRef",
        #   "Moid": "638f5f366275722d306a8b4d",
        #   "ObjectType": "snmp.Policy",
        #   "link": "https://www.intersight.com/api/v1/snmp/Policies/638f5f366275722d306a8b4d"
        # }


}