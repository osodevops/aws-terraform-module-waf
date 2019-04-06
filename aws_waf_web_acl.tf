resource "aws_wafregional_web_acl" "waf_web_acl" {
  depends_on  = ["aws_wafregional_rule.waf_whitelist_rule"]
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
    rule_id  = "${aws_wafregional_rule.waf_whitelist_rule.id}"
  }
}

resource "aws_wafregional_web_acl_association" "waf_web_acl_association" {
  depends_on   = ["aws_wafregional_web_acl.waf_web_acl"]
  count        = "${length(var.alb_arn)}"
  resource_arn = "${element(var.alb_arn, count.index)}"
  web_acl_id   = "${aws_wafregional_web_acl.waf_web_acl.id}"
}
