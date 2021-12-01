variable "Version" {
  type = string
  default = "3.0.0"
}
variable "aws_region" {
  type    = string
  default = "us-east-2"
}

variable "PipelineName" {
  type = string
  default = "ImageBuilderPipe2-TFE"
}
variable "RecipeName" {
  type = string
  default = "UbuntuRecipe2"
}
variable "InfraName" {
  type = string
  default = "Infra2-TFE"
}
variable "DistSetName" {
  type = string
  default = "DistSet2-TFE"
}

/*
component_arns = [
    "arn:aws:imagebuilder:${data.aws_region.current.name}:aws:component/InstallCLI/1.0.0",
    "arn:aws:imagebuilder:${data.aws_region.current.name}:aws:component/InstallCW/1.0.0"
  ]
  */