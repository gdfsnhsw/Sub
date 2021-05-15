{% if request.target == "clash" or request.target == "clashr" %}


mixed-port: {{ local.clash.mixed_port }}
redir-port: {{ local.clash.redir_port}}
authentication:
  - "user:user" 
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
tun:
  enable: true         
  stack: system
  dns-hijack:
    - tcp://8.8.8.8:53
    - tcp://8.8.4.4:53
    - 8.8.8.8:53
    - 8.8.8.8:53
dns:
  enable: true
  ipv6: false
  listen: 127.0.0.1:5352 
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
dns:
  enable: true
  ipv6: false
  listen: 127.0.0.1:5352         
{% endif %}

  default-nameserver:
    - 223.5.5.5
  enhanced-mode: fake-ip
  fake-ip-range: 198.19.0.1/16
  use-hosts: true




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
