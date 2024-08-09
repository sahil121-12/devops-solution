variable "ami" {
  description = "The Amazon Machine Image (AMI) ID for the EC2 instance"
  type        = string
  default     = "ami-0a4408457f9a03be3"  
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t3a.medium"
}


variable "tags" {
  description = "A map of tags to assign to the instance"
  type        = map(string)
  default     = {
    Name = "LogstashServer"
  }
}
