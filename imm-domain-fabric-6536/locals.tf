
locals {
  chassis_profile_moids = toset(intersight_chassis_profile.chassis_9508_profile[*].moid)
  
  # Create a list of chassis indexes Example of five chassis: [0,1,2,3,4]
  chassis_index = range(var.chassis_9508_count)

}
