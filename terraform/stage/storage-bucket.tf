terraform {
  backend "s3" {
    endpoints = {
      s3 = "http://storage.yandexcloud.net"
    }
    bucket     = "ivankiselev320"
    region     = "ru-central1"
    key        = "terraform/terraform.tfstate"
    access_key = "YCAJEUE4mBEtlYLIIu-T-Yg_v"
    secret_key = "YCMnqeYEreuIjUmwgYffP44B9VOVhpfsa9SNBnc1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
