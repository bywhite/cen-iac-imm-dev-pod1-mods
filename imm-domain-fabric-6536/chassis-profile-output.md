vmw_1_chassis_9508_profile_moids = {
  "account_moid" = "638a6acd7564612d330aaf54"
  "action" = "No-op"
  "action_params" = tolist([])
  "additional_properties" = "{\"AccountMoid\":\"638a6acd7564612d330aaf54\",\"Ancestors\":[],\"CreateTime\":\"2022-12-10T05:04:35.882Z\",\"Description\":\"9508 chassis profile\",\"DomainGroupMoid\":\"638a6acd7564612d330aaf55\",\"ModTime\":\"2022-12-10T05:04:35.901Z\",\"Moid\":\"6394136377696e2d317d8602\",\"Name\":\"dev-ofl-pod1-vmw1-Chassis-9508-2\",\"Owners\":[\"638a6acd7564612d330aaf54\"],\"PermissionResources\":[{\"ClassId\":\"mo.MoRef\",\"Moid\":\"638a810d6972652d3117fbec\",\"ObjectType\":\"organization.Organization\",\"link\":\"https://www.intersight.com/api/v1/organization/Organizations/638a810d6972652d3117fbec\"}],\"SharedScope\":\"\",\"SrcTemplate\":null,\"Tags\":[{\"Key\":\"Environment\",\"Value\":\"dev-ofl\"},{\"Key\":\"Orchestrator\",\"Value\":\"Terraform\"}],\"Type\":\"instance\"}"
  "ancestors" = tolist([])
  "assigned_chassis" = tolist([])
  "associated_chassis" = tolist([])
  "class_id" = "chassis.Profile"
  "config_change_details" = tolist([])
  "config_changes" = tolist([
    {
      "additional_properties" = ""
      "changes" = tolist([])
      "class_id" = "policy.ConfigChange"
      "disruptions" = tolist([])
      "object_type" = "policy.ConfigChange"
    },
  ])
  "config_context" = tolist([
    {
      "additional_properties" = ""
      "class_id" = "policy.ConfigContext"
      "config_state" = "Not-assigned"
      "config_type" = ""
      "control_action" = "deploy"
      "error_state" = "Validation-error"
      "object_type" = "policy.ConfigContext"
      "oper_state" = ""
    },
  ])
  "config_result" = tolist([
    {
      "additional_properties" = ""
      "class_id" = "mo.MoRef"
      "moid" = "6394136377696e2d317d8604"
      "object_type" = "chassis.ConfigResult"
      "selector" = ""
    },
  ])
  "create_time" = "2022-12-10 05:04:35.882 +0000 UTC"
  "description" = "9508 chassis profile"
  "domain_group_moid" = "638a6acd7564612d330aaf55"
  "id" = "6394136377696e2d317d8602"
  "iom_profiles" = tolist([
    {
      "additional_properties" = ""
      "class_id" = "mo.MoRef"
      "moid" = "6394136377696e2d317d8606"
      "object_type" = "chassis.IomProfile"
      "selector" = ""
    },
    {
      "additional_properties" = ""
      "class_id" = "mo.MoRef"
      "moid" = "6394136377696e2d317d8609"
      "object_type" = "chassis.IomProfile"
      "selector" = ""
    },
  ])
  "mod_time" = "2022-12-10 05:04:35.901 +0000 UTC"
  "moid" = "6394136377696e2d317d8602"
  "name" = "dev-ofl-pod1-vmw1-Chassis-9508-2"
  "object_type" = "chassis.Profile"
  "organization" = tolist([
    {
      "additional_properties" = ""
      "class_id" = "mo.MoRef"
      "moid" = "638a810d6972652d3117fbec"
      "object_type" = "organization.Organization"
      "selector" = ""
    },
  ])
  "owners" = tolist([
    "638a6acd7564612d330aaf54",
  ])
  "parent" = tolist([])
  "permission_resources" = tolist([
    {
      "additional_properties" = ""
      "class_id" = "mo.MoRef"
      "moid" = "638a810d6972652d3117fbec"
      "object_type" = "organization.Organization"
      "selector" = ""
    },
  ])
  "policy_bucket" = tolist([])
  "running_workflows" = tolist([])
  "shared_scope" = ""
  "src_template" = tolist([])
  "tags" = tolist([
    {
      "additional_properties" = ""
      "key" = "Environment"
      "value" = "dev-ofl"
    },
    {
      "additional_properties" = ""
      "key" = "Orchestrator"
      "value" = "Terraform"
    },
  ])
  "target_platform" = "FIAttached"
  "type" = "instance"
  "version_context" = tolist([])
  "wait_for_completion" = true
}