terraform {
  required_providers {
    serverspace = {
      source = "itglobalcom/serverspace"
      version = "0.3.1"
    }
  }
}

variable "s2_token" {
  type = string
  default = "063617ff377f0cc69fe997b51ee92043aaa319e3dc21782e22ae0a9982626322"
}

provider "serverspace" {
  key = var.s2_token
}
