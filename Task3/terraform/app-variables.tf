#Application Module - Variables

# Application definition

variable "app_name" {
  type        = string
  description = "Task3-Ubuntu"
}

variable "app_environment" {
  type        = string
  description = "Ubuntu"
}

variable "app_name_centos" {
  type        = string
  default     = "Task3-CentOS"
  description = "Task3-CentOS"
}

variable "app_environment_centos" {
  type        = string
  default     = "CentOS"
  description = "CentOS"
}
