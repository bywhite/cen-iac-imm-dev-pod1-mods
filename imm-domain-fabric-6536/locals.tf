
locals {

  # ===========================================================================
  # These locals are used mainly as examples of Terraform's transformational functions
  # More explicit variable creation may prove better for ease of management
  # ---------------------------------------------------------------------------

  # ===========================================================================
  # This section contains example steps for dynamically creating Server Chassis Names from a count
  #   (In the real world, you would explicitly provide the list of names for granular management)
  
  # Step 1: Create a list of chassis indexes Example of five chassis: [1,2,3,4,5]
  chassis_index_numbers  = range(1,var.chassis_9508_count + 1)
  # We start at 1 and since the range end number is "non-incluseive", we add 1 so it doesn't end at 4

  # Step 2: Convert the list of numbers to a set of strings so it can be used in for_each
  # This index set is used by for_each in the chassis profiles creation
  chassis_index_set     = toset([for v in local.chassis_index_numbers : tostring(v)])

  # Step 3: Use the chassis profiles created by module to extract a list of Chassis Profile moids
  chassis_profile_moids = values(intersight_chassis_profile.chassis_9508_profile)[*].id

  # Step 4: Similarly, extract list of Chassis Profile names from chassis profile objects
  chassis_profile_names = values(intersight_chassis_profile.chassis_9508_profile)[*].name
  # ---------------------------------------------------------------------------
  

  # ===========================================================================
  # This secton create a list of VLAN-Name:VLAN-Number pairs from list of allowed vlans 
  # var.switch_vlans_6536      # Example: "2-100,105,110,115 >> {"vlan-2": 2, "vlan-3": 3, ...}"
  vlan_split = length(regexall("-", var.switch_vlans_6536)) > 0 ? tolist(
    split(",", var.switch_vlans_6536)
  ) : tolist(var.switch_vlans_6536)
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
