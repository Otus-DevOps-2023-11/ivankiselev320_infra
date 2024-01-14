resource "yandex_lb_target_group" "tg" {
  name = "reddit"
  dynamic "target" {
    for_each = yandex_compute_instance.app
    content {
      subnet_id = var.subnet_id
      address   = target.value.network_interface.0.ip_address
    }
  }
}
resource "yandex_lb_network_load_balancer" "lb" {
  name = "reddit-lb"
  listener {
    name        = "reddit-app"
    port        = 9292
    target_port = 9292
    protocol    = "tcp"
    external_address_spec {
      ip_version = "ipv4"
    }
  }
  attached_target_group {
    target_group_id = yandex_lb_target_group.tg.id
    healthcheck {
      name = "healthcheck"
      http_options {
        port = 9292
        path = "/"
      }
    }
  }
}