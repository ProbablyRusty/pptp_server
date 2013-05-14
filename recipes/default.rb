#
# Cookbook Name:: pptp_server
# Recipe:: default
#
# Copyright 2013, Rusty Ross
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "sysctl"
include_recipe "simple_iptables"

package "pptpd" do
	action :install
end

pptp_server_file_admin_section "/etc/pptpd.conf" do
	filepath "/etc/pptpd.conf"
	section_name "Chef-managed settings (pptp_server cookbook)"
	content "localip   #{node[:pptp_server][:local_ip]}\nremoteip   #{node[:pptp_server][:client_pool]}"
	begin_comment_indicator '### '
	end_comment_indicator ' ###'
	action :manage
	notifies :restart, "service[pptpd]"
end

template "/etc/ppp/chap-secrets" do
	source "chap-secrets.erb"
	mode 0600
	owner "root"
	group "root"
	variables({:client_accts => node[:pptp_server][:client_accts]})
end

sysctl_param 'net.ipv4.ip_forward' do
    value 1
end

simple_iptables_rule "masquerade" do
    table "nat"
    direction "POSTROUTING"
    rule "-o eth0"
    jump "MASQUERADE"
end

service "pptpd" do
  supports :restart => true
  action [ :enable, :start ]
end
