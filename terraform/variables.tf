# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0


variable "region" {
  description = "AWS region"
  type        = string
}

variable "access_key" {
  description = "AWS access key"
  type        = string
}

variable "secret_key" {
  description = "AWS secret key"
  type        = string
}
