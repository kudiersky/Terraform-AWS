##Add Cloud Watch alarms

# Memory High 

resource "aws_cloudwatch_metric_alarm" "ec2_memory_high" {
  count               = "${var.instance_count}"
  alarm_name          = "${var.tags["application"]}-${var.tags["environment"]}-mem-util-high-${var.ami}-${count.index+1}"
  alarm_description   = "${var.tags["application"]} ${var.tags["environment"]} ec2 memory high utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "MemoryUtilization"
  namespace           = "System/${var.tags["os"]}"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_memory_high_threshold}"
  alarm_actions       = ["${var.alarm_actions_list}"]

  dimensions {
    InstanceId = "${element(aws_instance.ec2.*.id, count.index)}"
  }
}

# CPU High 

resource "aws_cloudwatch_metric_alarm" "ec2_cpu_high" {
  count               = "${var.instance_count}"
  depends_on          = ["aws_cloudwatch_metric_alarm.ec2_memory_high"]
  alarm_name          = "${var.tags["application"]}-${var.tags["environment"]}-cpu-util-high-${var.ami}-${count.index+1}"
  alarm_description   = "${var.tags["application"]} ${var.tags["environment"]} ec2 cpu high utilization"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods  = "2"
  metric_name         = "CPUUtilization"
  namespace           = "System/${var.tags["os"]}"
  period              = "300"
  statistic           = "Average"
  threshold           = "${var.alarm_cpu_high_threshold}"
  alarm_actions       = ["${var.alarm_actions_list}"]

  dimensions {
    InstanceId = "${element(aws_instance.ec2.*.id, count.index)}"
  }
}
