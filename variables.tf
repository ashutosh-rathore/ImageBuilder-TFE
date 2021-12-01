variable "aws_region" {
  type    = string
  default = "us-east-2"
}

/*
component_arns = [
    "arn:aws:imagebuilder:${data.aws_region.current.name}:aws:component/InstallCLI/1.0.0",
    "arn:aws:imagebuilder:${data.aws_region.current.name}:aws:component/InstallCW/1.0.0"
  ]
  */