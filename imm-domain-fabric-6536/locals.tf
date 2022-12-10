
locals {
  #chassis_profile_moids = toset(intersight_chassis_profile.chassis_9508_profile[*].moid)
  chassis_profile_moids = intersight_chassis_profile.chassis_9508_profile[2].config_result[2]
  
  # Create a list of chassis indexes Example of five chassis: [0,1,2,3,4]
  chassis_index_numbers  = range(var.chassis_9508_count)

  # Convert the list of numbers to a set of strings
  chassis_index_set     = toset([for v in local.chassis_index_numbers : tostring(v)])

}
