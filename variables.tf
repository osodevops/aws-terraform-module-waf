variable "account_name" {
  "type"        = "string"
}

variable "activate_badbot_protection_param" {
  default = "yes"
}

variable "activate_http_flood_protection_param" {
  default = "yes"
}

variable "activate_reputation_lists_protection_param" {
  default = "yes"
}

variable "activate_scans_probes_protection_param" {
  default = "yes"
}

variable "alb_arn" {
  type        = "list"
  description = "(Required) ARN of Application Load Balancer"
}

variable "common_tags" {
  type = "map"
}

variable "cross_site_scripting_protection_param" {
  default = "yes"
}

variable "environment" {
  "type"        = "string"
}

variable "s3_access_log_bucket" {
  "type"        = "string"
  "description" = "(Required) Enter a name for the Amazon S3 bucket where you want to store Amazon ALB access logs. This can be the name of either an existing S3 bucket, or a new bucket that the template will create during stack launch (if it does not find a matching bucket name). The solution will modify the bucket's notification configuration to trigger the Log Parser AWS Lambda function whenever a new log file is saved in this bucket. More about bucket name restriction here: http://amzn.to/1p1YlU5"
}

variable "send_anonymous_usage_data_to_aws" {
  default = "yes"
}

variable "sql_injection_protection_param" {
  default = "yes"
}


variable "waf_badbot_error_threshold" {
  default = "500"
}

variable "waf_badbot_request_threshold" {
  default = "800"
}

variable "waf_block_period" {
  default = "240"
}

variable "waf_whitelisted_ip_sets" {
  "type"        = "list"
  "description" = "List of Whitelisted IP addresses"
}

### Conditions ###

locals {
  is_sql_iInjectionProtectionActivated           = "${var.sql_injection_protection_param == "yes" ? 1 : 0}"
  is_cross_site_scripting_protection_activated  = "${var.cross_site_scripting_protection_param == "yes" ? 1 : 0}"
  is_http_flood_protection_activated            = "${var.activate_http_flood_protection_param == "yes" ? 1 : 0}"
  is_scans_probes_protection_activated          = "${var.activate_scans_probes_protection_param == "yes" ? 1 : 0}"
  is_reputation_lists_protection_activated      = "${var.activate_reputation_lists_protection_param == "yes" ? 1 : 0}"
  is_badbot_protection_activated                = "${var.activate_badbot_protection_param == "yes" ? 1 : 0}"
  is_log_parser_activated                       = "${var.activate_scans_probes_protection_param == "yes" ? 1 : 0}"
}

resource "random_string" "UniqueID" {
  length  = 32
  special = false
}