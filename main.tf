provider "alicloud" {
  region = "cn-hangzhou"
//  version = "=1.118.0"
}

data "alicloud_vpcs" "default" {
  is_default = true
}
resource "alicloud_security_group" "default" {
  name = "tftest"
  description = "privatelink test security group"
  vpc_id = data.alicloud_vpcs.default.ids.0
}
resource "alicloud_security_group" "default2" {
  name = "tf-testacc2142143"
  description = "privatelink test security group2"
  vpc_id = data.alicloud_vpcs.default.ids.0
}
resource "alicloud_privatelink_vpc_endpoint_service" "default" {
  service_description = "tf-testaccjk1924"
  connect_bandwidth = 103
  auto_accept_connection = false
}

resource "alicloud_privatelink_vpc_endpoint" "this" {
  service_id = alicloud_privatelink_vpc_endpoint_service.default.id
  vpc_id = data.alicloud_vpcs.default.ids.0
  security_group_ids = [alicloud_security_group.default.id]
  vpc_endpoint_name = "tf-testacck1o124"
  depends_on = [
    alicloud_privatelink_vpc_endpoint_service.default]

}

