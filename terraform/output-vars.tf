output "external_ip_address_app" {
  value = [yandex_compute_instance.app[0].network_interface.0.nat_ip_address, yandex_compute_instance.app[1].network_interface.0.nat_ip_address]
}
output "external_ip_address_nlb" {
  value = yandex_lb_network_load_balancer.nlb.listener.*.external_address_spec[0].*.address
}
