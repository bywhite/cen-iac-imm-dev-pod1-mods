# =============================================================================
#  Server Syslog Policies
# -----------------------------------------------------------------------------

# =============================================================================
# Syslog
# -----------------------------------------------------------------------------

resource "intersight_syslog_policy" "syslog_policy" {
  name               = "${var.policy_prefix}-syslog-01"
  description        = var.description
  local_clients {
    min_severity = "warning"
    object_type = "syslog.LocalFileLoggingClient"
  }
  remote_clients {
    enabled      = false
    hostname     = "${var.syslog_remote_host}"
    port         = 514
    protocol     = "udp"
    min_severity = "warning"
    object_type  = "syslog.RemoteLoggingClient"
  }
  organization {
    moid        = var.organization
    object_type = "organization.Organization"
  }
  dynamic "tags" {
    for_each = var.tags
    content {
      key   = tags.value.key
      value = tags.value.value
    }
  }
}
