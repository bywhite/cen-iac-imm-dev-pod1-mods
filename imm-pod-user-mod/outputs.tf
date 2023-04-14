# This module returns the Intersight IAM End Point User Policy Moid
# for use in the Server Profile Template for IMC access

output "iam_user_policy_moid" {
  description = "User Policy Moid for IMC local users"
  value       = intersight_iam_end_point_user_policy.pod_user_policy_1.moid
}