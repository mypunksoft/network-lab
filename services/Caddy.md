---
tags: [сеть, сервис, веб, прокси]
---
# Caddy

Системная служба на [[Server1 Banana Pi]] `192.0.2.152`. Слушает TCP `80/443` на сетевых интерфейсах Server1 и предоставляет HTTPS для внутренних имён `*.example.test`. Панель управления Caddy на `127.0.0.1:2019` доступна только локально. Приложения за Caddy в основном работают на [[Raspberry Pi 5]] `192.0.2.142`. [[NETWORK|Карта сети]]

| Имя | Backend | Состояние |
| --- | --- | --- |
| `ha.example.test` | [[Home Assistant]] `192.0.2.142:8123` | `200` |
| `ssh.example.test` | [[Guacamole]] `192.0.2.142:8090` | `200` |
| `router.example.test` | [[OpenWrt]] `192.0.2.1` | DNS указывает на Caddy `192.0.2.152`; прокси отвечает HTTP `200`. |
| `stat.example.test` | [[Cockpit]] `https://192.0.2.142:9090` | `200` |
| `vaultwarden.example.test` | [[Vaultwarden]] `192.0.2.142:5173` | `200` |
| `shell.example.test` | Статический shell на [[Raspberry Pi 5]] `192.0.2.142:8081` | `200` |
| `home.example.test` | Внутренний портал на [[Raspberry Pi 5]] `192.0.2.142:8082` | `200` |
| `files.example.test` | [[Fileshare]] `203.0.113.10:6574` | `200`: прокси обновлён 12 октября 2026 года. |
| `lilgit.example.test` | [[LilGit]] `203.0.113.10:8765` | `200`: прокси обновлён 12 октября 2026 года. |
| `vm.example.test` | [[Виртуализация]] / Cockpit Machines `https://203.0.113.10:9090` | `200`: добавлен 12 октября 2026 года. |

На [[OpenWrt]] статических port forward к Server1 не найдено, UPnP выключен. Публикация Caddy в публичный интернет не подтверждена.
