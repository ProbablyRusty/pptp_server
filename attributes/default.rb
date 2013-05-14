default[:pptp_server][:local_ip] = "172.16.0.50"
default[:pptp_server][:client_pool] = "172.16.0.100-200"

default[:pptp_server][:client_accts] = {
	"user1" => "pass1",
	"user2" => "pass2"
	}
