# No locals required

locals {
  
  # ===========================================================================
  # This secton create a list of VLAN-Name:VLAN-Number pairs from list of allowed vlans 
  # var.switch_vlans      # Example: "2-100,105,110,115 >> {"vlan-2": 2, "vlan-3": 3, ...}"
  vlan_split = length(regexall("-", var.switch_vlans)) > 0 ? tolist(
    split(",", var.switch_vlans)
  ) : tolist(var.switch_vlans)
  vlan_lists = [for s in local.vlan_split : length(regexall("-", s)) > 0 ? [
    for v in range(
      tonumber(element(split("-", s), 0)),
      (tonumber(element(split("-", s), 1)
    ) + 1)) : tonumber(v)] : [s]
  ]

  # Flatten the list of lists generated above into a single simple list
  flattened_vlan_list = flatten(local.vlan_lists)

  # Convert the list above into a set so it can be used by for_each
  vlan_list_set       = toset(local.flattened_vlan_list)
  # ---------------------------------------------------------------------------

}