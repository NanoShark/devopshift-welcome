variable "empty_ip" {
  default     = ""
}


resource "null_resource" "check_public_ip" {
  provisioner "local-exec" {
    command = <<EOT
      if [ -z "${var.empty_ip}" ]; then
        echo "ERROR: Public IP address was not assigned. " >&2
        exit 1
        else
        echo "We got the IP! ${var.empty_ip}"
      fi
    EOT
  }

  #depends_on = [aws_instance.vm]
}

