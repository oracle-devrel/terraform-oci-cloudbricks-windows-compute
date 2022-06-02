# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# variables.tf
#
# Purpose: The following script contains all the variables used inside the project

/********** Provider Variables NOT OVERLOADABLE **********/
variable "region" {
  description = "Target region where artifacts are going to be created"
}

variable "tenancy_ocid" {
  description = "OCID of tenancy"
}

variable "user_ocid" {
  description = "User OCID in tenancy."
}

variable "fingerprint" {
  description = "API Key Fingerprint for user_ocid derived from public API Key imported in OCI User config"
}

variable "private_key_path" {
  description = "Private Key Absolute path location where terraform is executed"

}
/********** Provider Variables NOT OVERLOADABLE **********/

/********** Brick Variables **********/
/********** SSH Key Variables **********/
variable "ssh_public_is_path" {
  description = "Describes if SSH Public Key is located on file or inside code"
  default     = false
}

variable "ssh_private_is_path" {
  description = "Describes if SSH Private Key is located on file or inside code"
  default     = false
}

variable "ssh_public_key" {
  description = "Defines SSH Public Key to be used in order to remotely connect to compute instance"
  type        = string

}

variable "ssh_private_key" {
  description = "Private key to log into machine"

}
/********** SSH Key Variables **********/


/********** Compute Variables **********/
variable "os_user" {
  description = "User that will log into windows"
  default     = "opc"
}

variable "userdata" {
  description = "Describes userdata placeholder variable"
  default     = "userdata"
}

variable "cloudinit_ps1" {
  description = "Describes cloudinit.ps1 powershell script placeholder variable"
  default     = "cloudinit.ps1"
}

variable "cloudinit_config" {
  description = "Describes cloudinit.yml powershell script placeholder variable"
  default     = "cloudinit.yml"
}

variable "setup_ps1" {
  description = "Describes setup.ps1 powershell script placeholder variable"
  default     = "setup.ps1"
}

variable "num_instances" {
  description = "Amount of instances to create"
  default     = 0
}

variable "label_zs" {
  type    = list(any)
  default = ["0", ""]
}


variable "compute_display_name_base" {
  description = "Defines the compute and hostname Label for created compute"
}

variable "instance_shape" {
  description = "Defines the shape to be used on compute creation"
}

variable "primary_vnic_display_name" {
  description = "Defines the Primary VNIC Display Name"
  default     = "primaryvnic"
}

variable "assign_public_ip_flag" {
  description = "Defines either machine will have or not a Public IP assigned. All Pvt networks this variable must be false"
  default     = false
}

variable "fault_domain_name" {
  type        = list(any)
  description = "Describes the fault domain to be used by machine"
  default     = ["FAULT-DOMAIN-1", "FAULT-DOMAIN-2", "FAULT-DOMAIN-3"]
}

variable "instance_image_ocid" {
  description = "Defines the OCID for the OS image to be used on artifact creation. Extract OCID from: https://docs.cloud.oracle.com/iaas/images/ or designated custom image OCID created by packer"
}

variable "private_ip" {
  description = "Describes the private IP required for machine"
  default     = null
}

variable "bkp_policy_boot_volume" {
  description = "Describes the backup policy attached to the boot volume"
  default     = "gold"
}


variable "is_compute_in_hub_dmz01" {
  description = "Defines if the compute is going to be created in Hub DMZ01 Subnet"
  default     = false
}

variable "is_compute_in_hub_svc01" {
  description = "Defines if the compute is going to be created in the Hub SharedSvc01 Subnet"
  default     = false
}

variable "is_winrm_configured_for_image" {
  description = "Defines if winrm is being used in this installation"
  default     = "true"
}


variable "is_winrm_configured_with_ssl" {
  description = "Use the https 5986 port for winrm by default. If that fails with a http response error: 401 - invalid content type, the SSL may not be configured correctly"
  default     = "true"
}

variable "windows_compute_instance_compartment_name" {
  description = "Defines the compartment name where the infrastructure will be created"
}

variable "windows_compute_network_compartment_name" {
  description = "Defines the compartment where the Network is currently located"
}

variable "compute_nsg_name" {
  description = "Name of the NSG associated to the compute"
  default     = ""
}

variable "instance_shape_config_memory_in_gbs" {
  description = "(Updatable) The total amount of memory available to the instance, in gigabytes."
  default     = ""
}

variable "instance_shape_config_ocpus" {
  description = "(Updatable) The total number of OCPUs available to the instance."
  default     = ""
}

variable "is_flex_shape" {
  description = "Boolean that describes if the shape is flex or not"
  default     = false
  type        = bool

}

variable "is_nsg_required" {
  description = "Boolean that describes if an NSG is associated to the machine"
  default     = false
  type        = bool

}

/********** Compute Variables **********/

/********** Datasource and Subnet Lookup related variables **********/
variable "compute_availability_domain_list" {
  type        = list(any)
  description = "Defines the availability domain list where OCI artifact will be created. This is a numeric value greater than 0"
}

variable "network_subnet_name" {
  description = "Defines the subnet display name where this resource will be created at"
}

variable "vcn_display_name" {
  description = "VCN Display name to execute lookup"
}


# Use the https 5986 port for winrm by default
# If that fails with a http response error: 401 - invalid content type, the SSL may not be configured correctly
# In that case you can switch to http 5985 by setting this to false, and configuring winrm to AllowUnencrypted traffic
variable "is_winrm_configured_for_ssl" {
  default = "true"
}

/********** Datasource related variables **********/

/********** Brick Variables **********/

