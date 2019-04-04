resource "aws_wafregional_ipset" "waf_whitelis_set" {
  name = "${upper(var.environment)}-WAF-WHITELIST-SET"

  ip_set_descriptor = "${var.waf_whitelisted_ip_sets}"

  lifecycle {
    ignore_changes = ["ip_set_descriptor"]
  }
}

resource "aws_wafregional_ipset" "waf_blacklist_set" {
  count = "${local.is_log_parser_activated}"
  name  = "${upper(var.environment)}-WAF_BLACKLIST-SET"

  lifecycle {
    ignore_changes = ["ip_set_descriptor"]
  }
}

resource "aws_wafregional_ipset" "waf_http_flood_set" {
  count = "${local.is_log_parser_activated}"
  name  = "${upper(var.environment)}-WAF-HTTP-FLOOD-SET"

  lifecycle {
    ignore_changes = ["ip_set_descriptor"]
  }
}

resource "aws_wafregional_ipset" "waf_scans_probes_set" {
  count = "${local.is_log_parser_activated}"
  name  = "${upper(var.environment)}-WAF-SCANS-PROBES-SET"

  lifecycle {
    ignore_changes = ["ip_set_descriptor"]
  }
}

resource "aws_wafregional_ipset" "waf_reputation_lists_set1" {
  count = "${local.is_reputation_lists_protection_activated}"
  name  = "${upper(var.environment)}-WAF-REPUTATION-LISTS-SETS1"

  lifecycle {
    ignore_changes = ["ip_set_descriptor"]
  }
}

resource "aws_wafregional_ipset" "waf_reputation_lists_set2" {
  count = "${local.is_reputation_lists_protection_activated}"
  name  = "${upper(var.environment)}-WAF-REPUTATION-LISTS-SETS2"

  lifecycle {
    ignore_changes = ["ip_set_descriptor"]
  }
}

resource "aws_wafregional_ipset" "waf_badbot_set" {
  count = "${local.is_badbot_protection_activated}"
  name  = "${upper(var.environment)}-WAF-BADBOT-SET"

  lifecycle {
    ignore_changes = ["ip_set_descriptor"]
  }
}