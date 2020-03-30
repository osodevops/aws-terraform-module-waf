resource "aws_wafregional_web_acl" "waf_web_acl" {
  depends_on  = [aws_wafregional_rule.waf_whitelist_rule]
  name        = "${upper(var.environment)}-WAF-WEB-ACL"
  metric_name = "SecurityAutomationsMaliciousRequesters"

  default_action {
    type = "ALLOW"
  }

  rule {
    action {
      type = "ALLOW"
    }

    priority = 201
    rule_id  = aws_wafregional_rule.waf_whitelist_rule.id
  }

  rule {
    action {
      type = "BLOCK"
    }

    priority = 401
    rule_id  = aws_wafregional_rule.waf_blacklist_rule.id
  }

  /*rule {
    action {
      type = "BLOCK"
    }

    priority = 402
    rule_id  = "${aws_wafregional_rate_based_rule.waf_http_flood_rule.id}"
  }*/

  rule {
    action {
      type = "BLOCK"
    }

    priority = 403
    rule_id  = aws_wafregional_rule.waf_scans_probes_rule[0].id
  }
  rule {
    action {
      type = "BLOCK"
    }

    priority = 404
    rule_id  = aws_wafregional_rule.waf_ip_reputation_lists_rule1[0].id
  }
  rule {
    action {
      type = "BLOCK"
    }

    priority = 405
    rule_id  = aws_wafregional_rule.waf_ip_reputation_lists_rule2[0].id
  }

  /* disabled together with API Gateway*/
  rule {
    action {
      type = "BLOCK"
    }

    priority = 406
    rule_id  = aws_wafregional_rule.waf_badbod_rule[0].id
  }

  rule {
    action {
      type = "BLOCK"
    }

    priority = 407
    rule_id  = aws_wafregional_rule.waf_sql_injection_rule[0].id
  }
  rule {
    action {
      type = "BLOCK"
    }

    priority = 408
    rule_id  = aws_wafregional_rule.waf_xss_rule[0].id
  }
}

resource "aws_wafregional_web_acl_association" "waf_web_acl_association" {
  depends_on   = [aws_wafregional_web_acl.waf_web_acl]
  count        = length(var.alb_arn)
  resource_arn = element(var.alb_arn, count.index)
  web_acl_id   = aws_wafregional_web_acl.waf_web_acl.id
}

