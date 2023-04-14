




resource "intersight_vnic_fc_network_policy" "fc_vsan_100" {
  name                = "${var.pod_policy_prefix}-fc-vsan-100"
  description         = var.description
  vsan_settings {
    id          = 100
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_vnic_fc_network_policy" "fc_vsan_101" {
  name                = "${var.pod_policy_prefix}-fc-vsan-101"
  description         = var.description
  vsan_settings {
    id          = 101
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_vnic_fc_network_policy" "fc_vsan_102" {
  name                = "${var.pod_policy_prefix}-fc-vsan-102"
  description         = var.description
  vsan_settings {
    id          = 102
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_vnic_fc_network_policy" "fc_vsan_200" {
  name                = "${var.pod_policy_prefix}-fc-vsan-200"
  description         = var.description
  vsan_settings {
    id          = 200
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_vnic_fc_network_policy" "fc_vsan_201" {
  name                = "${var.pod_policy_prefix}-fc-vsan-201"
  description         = var.description
  vsan_settings {
    id          = 201
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}

resource "intersight_vnic_fc_network_policy" "fc_vsan_202" {
  name                = "${var.pod_policy_prefix}-fc-vsan-202"
  description         = var.description
  vsan_settings {
    id          = 202
    object_type = "vnic.VsanSettings"
  }
  organization {
    object_type = "organization.Organization"
    moid        = var.organization
  }
}
