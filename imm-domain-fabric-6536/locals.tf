
locals {
  chassis_profile_moids = toset(intersight_chassis_profile.chassis_9508_profile[*].moid)
  
}
