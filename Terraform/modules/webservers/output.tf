output "webservers_asg_id" {
  value = aws_autoscaling_group.webservers_asg.id
}

output "security_group_id" {
  value = aws_security_group.webservers_sg.id
}
