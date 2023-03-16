// Variables for Resources
variable "location" {
  description = "Resource location"
  type        = string
}
variable "tags" {
  description = "Resource tags"
  type        = map(string)
}
variable "environment" {
  description = "Environment name"
  type        = string
}

// Variables for Virtual Network and Subnet
variable "vnet_address_space" {
  description = "Virtual Network Address Space"
  type        = list(string)
}
variable "subnet_address_prefix" {
  description = "Subnet Address Prefix"
  type        = list(string)
}


// Variables for VM
variable "key_vault_key_id" {
  description = "The Key Vault Key ID which should be used for Disk Encryption"
  type        = string
}

variable "user_assigned_identity_id" {
  description = "The User Assigned Identity ID which should be used for Disk Encryption"
  type        = string
}

variable "disk_encryption_set_id" {
  description = "The Disk Encryption Set ID which should be used for Disk Encryption"
  type        = string
}

variable "vm_size" {
  description = "The size of the VM"
  type        = string
}

variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

variable "admin_password" {
  description = "The admin password for the VM"
  type        = string
}

// Variables for Key Vault