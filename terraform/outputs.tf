output "internal_ip_address_load_balancers" {
  value = yandex_compute_instance.lb-[*].network_interface.0.ip_address
}

output "external_ip_address_load_balancers" {
  value = yandex_compute_instance.lb-[*].network_interface.0.nat_ip_address
}

output "internal_ip_address_web_servers" {
  value = yandex_compute_instance.web-[*].network_interface.0.ip_address
}

output "external_ip_address_web_servers" {
  value = yandex_compute_instance.web-[*].network_interface.0.nat_ip_address
}

output "internal_ip_address_db_server" {
  value = yandex_compute_instance.db-[*].network_interface.0.ip_address
}

output "external_ip_address_db_server" {
  value = yandex_compute_instance.db-[*].network_interface.0.nat_ip_address
}

output "internal_ip_address_iscsi" {
  value = yandex_compute_instance.iscsi-[*].network_interface.0.ip_address
}

output "external_ip_address_iscsi" {
  value = yandex_compute_instance.iscsi-[*].network_interface.0.nat_ip_address
}

output "internal_ip_address_elk" {
  value = yandex_compute_instance.elk-[*].network_interface.0.ip_address
}

output "external_ip_address_elk" {
  value = yandex_compute_instance.elk-[*].network_interface.0.nat_ip_address
}

output "internal_ip_address_kafka" {
  value = yandex_compute_instance.kafka-[*].network_interface.0.ip_address
}

output "external_ip_address_kafka" {
  value = yandex_compute_instance.kafka-[*].network_interface.0.nat_ip_address
}


resource "local_file" "AnsibleInventory" {
 content = templatefile("inventory.tpl",
 {
  db-0-ip = yandex_compute_instance.db-[0].network_interface.0.nat_ip_address
  db-1-ip = yandex_compute_instance.db-[1].network_interface.0.nat_ip_address
  db-2-ip = yandex_compute_instance.db-[2].network_interface.0.nat_ip_address
  web-0-ip = yandex_compute_instance.web-[0].network_interface.0.nat_ip_address
  web-1-ip = yandex_compute_instance.web-[1].network_interface.0.nat_ip_address
  web-2-ip = yandex_compute_instance.web-[2].network_interface.0.nat_ip_address
  lb-0-ip = yandex_compute_instance.lb-[0].network_interface.0.nat_ip_address
  lb-1-ip = yandex_compute_instance.lb-[1].network_interface.0.nat_ip_address
  iscsi-0-ip = yandex_compute_instance.iscsi-[0].network_interface.0.nat_ip_address
  elk-0-ip = yandex_compute_instance.elk-[0].network_interface.0.nat_ip_address
  kafka-0-ip = yandex_compute_instance.kafka-[0].network_interface.0.nat_ip_address
 }
 )
 filename = "../ansible/inventory"
}

resource "local_file" "web_hosts_file" {
 content = templatefile("hosts.tpl",
  {
   db-0-ip = yandex_compute_instance.db-[0].network_interface.0.ip_address
   db-1-ip = yandex_compute_instance.db-[1].network_interface.0.ip_address
   db-2-ip = yandex_compute_instance.db-[2].network_interface.0.ip_address
   web-0-ip = yandex_compute_instance.web-[0].network_interface.0.ip_address
   web-1-ip = yandex_compute_instance.web-[1].network_interface.0.ip_address
   web-2-ip = yandex_compute_instance.web-[2].network_interface.0.ip_address
   lb-0-ip = yandex_compute_instance.lb-[0].network_interface.0.ip_address
   lb-1-ip = yandex_compute_instance.lb-[1].network_interface.0.ip_address
   iscsi-0-ip = yandex_compute_instance.iscsi-[0].network_interface.0.nat_ip_address
   elk-0-ip = yandex_compute_instance.elk-[0].network_interface.0.nat_ip_address
   kafka-0-ip = yandex_compute_instance.kafka-[0].network_interface.0.nat_ip_address
  }
 )
 filename = "../ansible/hosts"
}

resource "local_file" "load_balance_conf" {
 content = templatefile("load_balancer.conf.tpl",
  {
   web-0-ip = yandex_compute_instance.web-[0].network_interface.0.ip_address
   web-1-ip = yandex_compute_instance.web-[1].network_interface.0.ip_address
   web-2-ip = yandex_compute_instance.web-[2].network_interface.0.ip_address
  }
 )
 filename = "../ansible/roles/load_balancer/files/load_balancer.conf"
}