

locals {

# Create a list of chassis indexes Example of five chassis: [0,1,2,3,4]
  chassis_index = range(var.chassis_9508_count)
}