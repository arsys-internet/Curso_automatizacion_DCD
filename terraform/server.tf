data "ionoscloud_template" "example" {
    name            = "CUBES XS"
}

resource "ionoscloud_lan" "example" {
  datacenter_id     = ionoscloud_datacenter.demotf.id
  public            = true
  name              = "Red TF"
}

resource "ionoscloud_server" "example" {
  name              = "Servidor Demo"
  availability_zone = "AUTO"
  image_name        = "ubuntu:latest"
  type              = "CUBE"
  template_uuid     = data.ionoscloud_template.example.id
  image_password    = random_password.server_image_password.result
  datacenter_id     = ionoscloud_datacenter.demotf.id
  volume {
    name            = "Demo Volumen"
    licence_type    = "LINUX" 
    disk_type       = "DAS"
  }
  nic {
    lan             = ionoscloud_lan.example.id
    name            = "NIC Demo"
    dhcp            = true
    firewall_active = true
  }
}
resource "random_password" "server_image_password" {
  length           = 16
  special          = false
}
