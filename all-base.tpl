{% if request.target == "clash" or request.target == "clashr" %}


mixed-port: {{ local.clash.mixed_port }}
redir-port: {{ local.clash.redir_port}}
#authentication:
#  - "user:user" 
allow-lan: {{ local.clash.allow_lan }}
mode: Script
log-level: {{ local.clash.log_level }}
ipv6: false
external-controller: {{ local.clash.api_port}}
external-ui: dashboard
secret: ''
interface-name: {{ local.clash.interface-name}}
profile:
  store-selected: true
  tracing: false

# 实验性功能
experimental:
  ignore-resolve-fail: true

{% if exists("request.clash.dns") %}
{% if request.clash.dns == "tap" %}
ipv6: true
#interface-name: WLAN
hosts:
dns:
  enable: true
  listen: 0.0.0.0:53
  ipv6: true
{% endif %}
{% if request.clash.dns == "tun" %}
ipv6: false
tun:
  enable: true
  stack: system # or gvisor
  dns-hijack:
    - 198.18.0.2:53 # when `fake-ip-range` is 198.18.0.1/16, should hijack 198.18.0.2:53
  macOS-auto-route: true # auto set global route for Windows
  macOS-auto-detect-interface: true # auto detect interface, conflict with `interface-name`
#interface-name: WLAN
hosts:
dns:
  enable: true
#  listen: 0.0.0.0:53
  ipv6: false
{% endif %}
{% if request.clash.dns == "cfa" %}
ipv6: false
tun:
  enable: true
  stack: system # or gvisor
hosts:
dns:
  enable: true
  listen: 127.0.0.1:1053
  ipv6: false
{% endif %}
{% else %}
tun:
  enable: true         
  stack: gvisor
  dns-hijack:
    - tcp://8.8.8.8:53
    - tcp://8.8.4.4:53
    - 8.8.8.8:53
    - 8.8.8.8:53

# DNS设置  
dns:
  enable: true
  ipv6: false
  listen: 127.0.0.1:5352         
    default-nameserver:
    - 223.5.5.5
  enhanced-mode: fake-ip
  fake-ip-range: 198.19.0.1/16
  use-hosts: true
{% endif %}


  fake-ip-filter:
    - msftconnecttest.com
    - "*.msftconnecttest.com"
    - msftncsi.com
    - "*.msftncsi.com"
    - '.lan'
    - localhost.ptlogin2.qq.com    
    - '.srv.nintendo.net'   
    - '.stun.playstation.net'   
    - 'xbox.*.microsoft.com'    
    - '.xboxlive.com'
  nameserver:
    - 223.5.5.5

{% endif %}
