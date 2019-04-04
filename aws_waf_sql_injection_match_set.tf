resource "aws_wafregional_sql_injection_match_set" "waf_sql_injection_detection" {
  count = "${local.SqlInjectionProtectionActivated}"
  name  = "${upper(var.environment)}-WAF-SQL-INJECTION-DETECTION"

  sql_injection_match_tuple {
    text_transformation = "URL_DECODE"

    field_to_match {
      type = "QUERY_STRING"
    }
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "QUERY_STRING"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "BODY"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "BODY"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "URI"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "URI"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Cookie"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }

    text_transformation = "URL_DECODE"
  }

  sql_injection_match_tuple {
    field_to_match {
      type = "HEADER"
      data = "Authorization"
    }

    text_transformation = "HTML_ENTITY_DECODE"
  }
}