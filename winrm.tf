# Copyright (c) 2021 Oracle and/or its affiliates.
# All rights reserved. The Universal Permissive License (UPL), Version 1.0 as shown at http://oss.oracle.com/licenses/upl
# winrm.tf
#
# Purpose: The following script enables remote winrm and takes care of updating the password so first use is possible


######################################## WINDOWS COMPUTE RELATED VARS ########################################

resource "random_string" "instance_password" {
  length  = 16
  special = true
}


######################################## WINDOWS COMPUTE RELATED VARS ########################################


resource "null_resource" "wait_for_cloudinit" {
  depends_on = [
    oci_core_instance.Compute,
  ]

  count = var.is_winrm_configured_for_image == "true" ? 1 : 0

  # WinRM configuration through cloudinit may not have completed and password may not have changed yet, so sleep before doing remote-exec
  provisioner "local-exec" {
    command = "sleep 120"
  }
}

resource "null_resource" "remote-exec-windows" {
  # This step is simply to test that cloud_init has completed. If this step fails, please retry
  depends_on = [
    oci_core_instance.Compute,
    null_resource.wait_for_cloudinit,
  ]

  # WinRM connections via Terraform are going to fail if it is not configured correctly as mentioned in comment section above
  count = var.is_winrm_configured_for_image == "true" ? 1 : 0

  provisioner "file" {
    connection {
      type     = "winrm"
      agent    = false
      timeout  = "5m"
      host     = oci_core_instance.Compute[count.index].private_ip
      user     = "opc"
      password = random_string.instance_password.result
      port     = var.is_winrm_configured_for_ssl == "true" ? 5986 : 5985
      https    = var.is_winrm_configured_for_ssl
      insecure = "true" #self-signed certificate
    }

    content     = data.template_cloudinit_config.cloudinit_config[count.index].rendered
    destination = "c:/setup.ps1"
  }
}
