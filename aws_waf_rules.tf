resource "aws_wafregional_rule" "waf_whitelist_rule" {
  depends_on  = ["aws_wafregional_ipset.waf_whitelis_set"]
  name        = "${upper(var.environment)}-WAF_WHITELIST_RULE"
  metric_name = "SecurityAutomationsWhitelistRule"

  predicate {
    type    = "IPMatch"
    data_id = "${aws_wafregional_ipset.waf_whitelis_set.id}"
    negated = false
  }
}

resource "aws_wafregional_rule" "waf_blacklist_rule" {
  depends_on  = ["aws_wafregional_ipset.waf_blacklist_set"]
  name        = "${upper(var.environment)}-WAF-BLACKLIST-RULE"
  metric_name = "SecurityAutomationsBlacklistRule"

  predicate {
    type    = "IPMatch"
    data_id = "${aws_wafregional_ipset.waf_blacklist_set.id}"
    negated = false
  }
}

resource "aws_wafregional_rate_based_rule" "waf_http_flood_rule" {
  depends_on  = ["aws_wafregional_ipset.waf_http_flood_set"]
  name        = "${upper(var.environment)}-WAF-HTTP-FLOOD-RULE"
  metric_name = "SecurityAutomationsHttpFloodRule"

  rate_key   = "IP"
  rate_limit = "${var.waf_badbot_request_threshold}"

  predicate {
    data_id = "${aws_wafregional_ipset.waf_http_flood_set.id}"
    negated = false
    type    = "IPMatch"
  }
}

resource "aws_wafregional_rule" "waf_scans_probes_rule" {
  count       = "${local.is_log_parser_activated}"
  depends_on  = ["aws_wafregional_ipset.waf_scans_probes_set"]
  name        = "${upper(var.environment)}-WAF-SCANS-PROBES-RULE"
  metric_name = "SecurityAutomationsScansProbesRule"

  predicate {
    type    = "IPMatch"
    data_id = "${aws_wafregional_ipset.waf_scans_probes_set.id}"
    negated = false
  }
}

resource "aws_wafregional_rule" "waf_ip_reputation_lists_rule1" {
  count       = "${local.is_reputation_lists_protection_activated}"
  depends_on  = ["aws_wafregional_ipset.waf_reputation_lists_set1"]
  name        = "${upper(var.environment)}-WAF-IP-REPUTATION-LISTS-RULE1"
  metric_name = "SecurityAutomationsIPReputationListsRule1"

  predicate {
    type    = "IPMatch"
    data_id = "${aws_wafregional_ipset.waf_reputation_lists_set1.id}"
    negated = false
  }
}

resource "aws_wafregional_rule" "waf_ip_reputation_lists_rule2" {
  count       = "${local.is_reputation_lists_protection_activated}"
  depends_on  = ["aws_wafregional_ipset.waf_reputation_lists_set2"]
  name        = "${upper(var.environment)}-WAF-IP-REPUTATION-LISTS-RULE2"
  metric_name = "SecurityAutomationsIPReputationListsRule2"

  predicate {
    type    = "IPMatch"
    data_id = "${aws_wafregional_ipset.waf_reputation_lists_set2.id}"
    negated = false
  }
}

resource "aws_wafregional_rule" "waf_badbod_rule" {
  count       = "${local.is_badbot_protection_activated}"
  depends_on  = ["aws_wafregional_ipset.waf_badbot_set"]
  name        = "${upper(var.environment)}-WAF-BADBOT-RULE"
  metric_name = "SecurityAutomationsBadBotRule"

  predicate {
    type    = "IPMatch"
    data_id = "${aws_wafregional_ipset.waf_badbot_set.id}"
    negated = false
  }
}

resource "aws_wafregional_rule" "waf_sql_injection_rule" {
  count       = "${local.is_sql_injection_protection_activated}"
  depends_on  = ["aws_wafregional_sql_injection_match_set.waf_sql_injection_detection"]
  name        = "${upper(var.environment)}-WAF-SQL-INJECTION-RULE"
  metric_name = "SecurityAutomationsSqlInjectionRule"

  predicate {
    type    = "SqlInjectionMatch"
    data_id = "${aws_wafregional_sql_injection_match_set.waf_sql_injection_detection.id}"
    negated = false
  }
}

resource "aws_wafregional_rule" "waf_xss_rule" {
  count       = "${local.is_cross_site_scripting_protection_activated}"
  depends_on  = ["aws_wafregional_xss_match_set.waf_xss_dectection"]
  name        = "${upper(var.environment)}-WAF-XSS-RULE"
  metric_name = "SecurityAutomationsXssRule"

  predicate {
    type    = "XssMatch"
    data_id = "${aws_wafregional_xss_match_set.waf_xss_dectection.id}"
    negated = false
  }
}