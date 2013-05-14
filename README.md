pptp_server
================

This Chef cookbook installs, enables, and configures a PPTP server.

Platorms
========

It has been tested on installations of Ubuntu and Red Hat, and should work on many other flavors of Linux as well.

Requirements
============

This cookbook depends on two other Chef Community Cookbooks:

* [simple_iptables](http://community.opscode.com/cookbooks/simple_iptables)

* [sysctl](http://community.opscode.com/cookbooks/sysctl)

Attributes
==========

By setting attributes in attributes/default.rb, you can specify the private IP of your PPTP server, a range of IP addresses (usually in the same subnet as the private IP of the PPTP server) for the PPTP server to use as a pool to assign to PPTP clients when they connect, and one or more username and password pairs for clients to use as login credentials.

#### pptp_server::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['pptp_server'][:local_ip]</tt></td>
    <td>String</td>
    <td>Private IP of PPTP server</td>
    <td><tt>172.16.0.50</tt></td>
  </tr>
  <tr>
    <td><tt>['pptp_server'][:client_pool]</tt></td>
    <td>String</td>
    <td>Range of private IPs for PPTP clients</td>
    <td><tt>172.16.0.100-200</tt></td>
  </tr>
   <tr>
    <td><tt>['pptp_server'][:client_accts]</tt></td>
    <td>Hash</td>
    <td>Usernames and passwords for PPTP clients</td>
    <td><tt>User1/pass1, User2/pass2</tt></td>
  </tr> 
</table>

Usage
=====

#### pptp-server::default

Just include `pptp_server` in your node's `run_list`, in addition to the dependencies noted above:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[pptp_server]"
  ]
}
```

Once enabled, the PPTP service will remain enabled after system reboots.

License and Author
==================

Author: Rusty Ross

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
