{
  "Statement": [
    {
      "Condition": {
        "ArnEquals": {
          "ecs:cluster": "arn:aws:ecs:${region}:${account_id}:cluster/${ecs_cluster}"
        }
      },
      "Action": [
        "ecs:StartTask"
      ],
      "Resource": "*",
      "Effect": "Allow"
    },
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogStreams"
      ],
      "Resource": [
        "arn:aws:logs:${region}:${account_id}:log-group:${instance_log_group_name}",
        "arn:aws:logs:${region}:${account_id}:log-group:${instance_log_group_name}:*",
        "arn:aws:logs:${region}:${account_id}:log-group:svc-lg-*",
        "arn:aws:logs:${region}:${account_id}:log-group:svc-lg-*:*"
      ],
      "Effect": "Allow"
    },
    {
      "Effect": "Allow",
      "Action": [
        "xray:PutTraceSegments",
        "xray:PutTelemetryRecords"
      ],
      "Resource": [
          "*"
      ]
    }
  ]
}