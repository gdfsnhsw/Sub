{% if request.target == "clash" or request.target == "clashr" %}


mixed-port: {{ local.clash.mixed_port }}
redir-port: {{ local.clash.redir_port}}
authentication:
  - "clash_ui:667788" 
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
    # === LAN ===
    - '*.lan'
    - '*.localdomain'
    - '*.example'
    - '*.invalid'
    - '*.localhost'
    - '*.test'
    - '*.local'
    - '*.home.arpa'
    # === Linksys Wireless Router ===
    - '*.linksys.com'
    - '*.linksyssmartwifi.com'
    # === ASUS Router ===
    - '*.router.asus.com'
    # === Apple Software Update Service ===
    - 'swscan.apple.com'
    - 'mesu.apple.com'
    # === Windows 10 Connnect Detection ===
    - '*.msftconnecttest.com'
    - '*.msftncsi.com'
    - 'msftconnecttest.com'
    - 'msftncsi.com'
    # === Google ===
    - 'lens.l.google.com'
    - 'stun.l.google.com'
    ## Golang
    - 'proxy.golang.org'
    # === NTP Service ===
    - 'time.*.com'
    - 'time.*.gov'
    - 'time.*.edu.cn'
    - 'time.*.apple.com'
    - 'time1.*.com'
    - 'time2.*.com'
    - 'time3.*.com'
    - 'time4.*.com'
    - 'time5.*.com'
    - 'time6.*.com'
    - 'time7.*.com'
    - 'ntp.*.com'
    - 'ntp1.*.com'
    - 'ntp2.*.com'
    - 'ntp3.*.com'
    - 'ntp4.*.com'
    - 'ntp5.*.com'
    - 'ntp6.*.com'
    - 'ntp7.*.com'
    - '*.time.edu.cn'
    - '*.ntp.org.cn'
    - '+.pool.ntp.org'
    - 'time1.cloud.tencent.com'
    # === Game Service ===
    ## Nintendo Switch
    - '+.srv.nintendo.net'
    ## Sony PlayStation
    - '+.stun.playstation.net'
    ## Microsoft Xbox
    - 'xbox.*.microsoft.com'
    - 'xnotify.xboxlive.com'
    # === Other ===
    ## QQ Quick Login
    - 'localhost.ptlogin2.qq.com'
    - 'localhost.sec.qq.com'
    ## STUN Server
    - 'stun.*.*'
    - 'stun.*.*.*'
    - '+.stun.*.*'
    - '+.stun.*.*.*'
    - '+.stun.*.*.*.*'
  nameserver:
    - 223.5.5.5

{% endif %}
