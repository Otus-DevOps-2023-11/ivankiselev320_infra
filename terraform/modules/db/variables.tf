variable "public_key_path" {
  description = "Path to the public key used for ssh access"
}
variable "service_account_key_file" {
  description = "key .json"
  default     = "./key.json"
}
variable "db_disk_image" {
  description = "Disk image for reddit app"
  default     = "fd8bimueg14j9p9o4oa4"
}
variable "subnet_id" {
  description = "Subnet"
}
variable "private_key_path" {
  description = "Path to the private key"
}
