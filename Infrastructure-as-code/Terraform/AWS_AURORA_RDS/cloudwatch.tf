data "aws_cloudwatch_log_group" "slow_query_log_group" {
  depends_on = [module.aurora_and_cw]
  name = "/aws/rds/cluster/${module.aurora_and_cw.cluster_identifier}/slowquery"

}

resource "aws_cloudwatch_log_metric_filter" "slow_query_log_metric" {
  depends_on = [data.aws_cloudwatch_log_group.slow_query_log_group]
  name           = "slow_query_log"
  pattern        = ""
  log_group_name = data.aws_cloudwatch_log_group.slow_query_log_group.name

  metric_transformation {
    name      = "slow_query_log"
    namespace = "RDSLogMetrics"
    value     = 1
    default_value = 0
  }
}


resource "aws_cloudwatch_dashboard" "slow_query_dashboard" {
  depends_on = [aws_cloudwatch_log_metric_filter.slow_query_log_metric]
  dashboard_name = var.dashboard_name

  dashboard_body = <<EOF
 {
   "widgets": [
       {
          "type":"metric",
          "x":0,
          "y":0,
          "width":12,
          "height":6,
          "properties":{
             "metrics":[
                [
                  "AWS/Logs", "${aws_cloudwatch_log_metric_filter.slow_query_log_metric.name}",
                  "LogGroupName", "${data.aws_cloudwatch_log_group.slow_query_log_group.name}",
                  {"label": "Analyzer"}
                ]
             ],
             "period":300,
             "stat":"Average",
             "region":"${var.region}",
             "title":"RDS Slow Query Metric"
          }
       },
       {
          "type":"text",
          "x":0,
          "y":7,
          "width":3,
          "height":3,
          "properties":{
             "markdown":"SLOW QUERY"
          }
       }
   ]
 }
 EOF

}



