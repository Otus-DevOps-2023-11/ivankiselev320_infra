variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "service_account_key_file" {
  description = "key .json"
  default     = "./key.json"
}
variable "app_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8ehhhl0p67uearc16b"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "DATABASE_URL" {
  description = "Disk image for reddit app"
  default     = "reddit-db.ru-central1.internal"
}
variable "private_key_path" {
  description = "Path to the private key"
}
