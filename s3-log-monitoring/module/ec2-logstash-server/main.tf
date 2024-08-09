data "template_file" "launch_temp_user_data" {
  template = file("${path.module}/template.tpl")
}
resource "aws_security_group" "logstash_sg" {
  name        = "logstash_sg"
  description = "Security group for Logstash server"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 9200
    to_port     = 9200
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "logstash_sg"
  }
}
resource "aws_iam_role" "ssm_role" {
  name = "ssm_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action    = "sts:AssumeRole",
        Effect    = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "ssm_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
  role     = aws_iam_role.ssm_role.name
}

resource "aws_iam_instance_profile" "ssm_instance_profile" {
  name = "ssm_instance_profile"
  role = aws_iam_role.ssm_role.name
}

 
 resource "aws_instance" "logstash" {
  ami           = var.ami
  instance_type = var.instance_type
  security_groups = [aws_security_group.logstash_sg.name]

  iam_instance_profile = aws_iam_instance_profile.ssm_instance_profile.name

  user_data = data.template_file.launch_temp_user_data.rendered

  tags = var.tags
}

# resource "aws_instance" "logstash" {
#   ami           = var.ami
#   instance_type = var.instance_type
#   security_groups = [aws_security_group.logstash_sg.name]

#   user_data = data.template_file.launch_temp_user_data.rendered

#   tags = var.tags
# }

