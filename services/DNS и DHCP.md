---
tags: [сеть, сервис, инфраструктура]
---
# DNS и DHCP

На [[OpenWrt]] работают `dnsmasq` и `odhcpd`. `dnsmasq` слушает DNS TCP/UDP `53` на интерфейсах роутера и DHCP UDP `67`; `odhcpd` слушает DHCPv6 UDP `547`. LAN роутера — `192.0.2.1/24`. [[NETWORK|Карта сети]] · [[Сегменты сети]]

На [[Server2]] работает `systemd-resolved` как локальный DNS-резолвер. DHCP-пулы, остальные DNS-записи и форвардеры не проверялись.
26 октября 2026 года проверена запись dnsmasq `/hl/192.0.2.152`: внутренние имена `*.example.test`, включая `router.example.test`, направляются на [[Caddy]] на [[Server1 Banana Pi]]. Приложения за Caddy находятся на [[Raspberry Pi 5]] `192.0.2.142`. Прежнее отдельное исключение для `router.example.test → 192.0.2.1` удалено.
