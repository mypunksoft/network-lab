---
aliases: [Raspberry Pi, RPi5]
tags: [сеть, сервер, миграция, проверено]
---

# Raspberry Pi 5

> [!info] Паспорт
> Raspberry Pi 5 · Ubuntu Server 26.04.1 LTS · ARM64 · адрес `192.0.2.142/24` · шлюз [[OpenWrt]] `192.0.2.1`. Wi‑Fi отключён, используется Ethernet. Проверено 26 октября 2026 года.

[[NETWORK|Карта сети]] · [[Сегменты сети]]

## Сервисы

На узле запущены Docker-контейнеры, перенесённые с Banana Pi:

| Сервис | Порт | Состояние |
| --- | --- | --- |
| [[Home Assistant]] | `8123`, host network | `Up` |
| [[Guacamole]] | `8090` | `Up` |
| `guacd` | только Docker-сеть | `Up`, healthy |
| `guac-db` / MariaDB | только Docker-сеть | `Up` |
| [[Mosquitto]] | `1883`, `9001` | `Up` |
| [[Bot sii]] | исходящие Telegram/MQTT/HTTP-соединения | `liltorrent-bot.service`, `active`, пользователь `portfolio` |
| [[Vaultwarden]] | `192.0.2.142:5173` | `Up`, healthy |
| [[Cockpit]] | `9090` | активен через `cockpit.socket` |

Статические сервисы портала работают на `8081` (`shell.example.test`) и `8082` (`home.example.test`).

## Прокси

[[Caddy]] работает на [[Server1 Banana Pi]] `192.0.2.152` и проксирует на этот узел:

- `ha.example.test` → `192.0.2.142:8123`
- `ssh.example.test` → `192.0.2.142:8090`
- `stat.example.test` → `https://192.0.2.142:9090`
- `vaultwarden.example.test` → `192.0.2.142:5173`
- `shell.example.test` → `192.0.2.142:8081`
- `home.example.test` → `192.0.2.142:8082`

DNS wildcard `*.example.test` на [[OpenWrt]] указывает на Caddy `192.0.2.152`.

Бот обращается к [[LilTorrent]] на [[Server2]] по адресу `203.0.113.10:3000`. Старый `botsii.service` от пользователя `pi` остановлен.
