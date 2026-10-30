---
tags: [сеть, сервис, загрузки, telegram]
---

# LilTorrent

Веб-панель и API для qBittorrent на [[Server2]] `203.0.113.10`. Запущен systemd-сервис `liltorrent.service` от пользователя `portfolio`:

```text
/usr/bin/node /opt/liltorrent/server.js
```

Сервис слушает HTTP `0.0.0.0:3000`; локальная проверка 26 октября 2026 года вернула HTTP `200`. qBittorrent работает рядом на `127.0.0.1:8080`.

## Telegram-бот

Python-бот находится на [[Raspberry Pi 5]] `192.0.2.142` и обращается к API по адресу:

```text
http://203.0.113.10:3000
```

Сервис бота — `liltorrent-bot.service`, пользователь `portfolio`, каталог `/home/portfolio/liltorrent-bot`. Telegram-прокси и MQTT/WoL остаются на Raspberry Pi.

Поддерживаются:

- загрузка `.torrent` до 10 МБ;
- magnet/HTTP-ссылки;
- `/list` и `/history`;
- пауза, продолжение и удаление через inline-кнопки;
- уведомления о завершённых загрузках.

## Автоочистка

Сервер проверяет категорию `liltorrent`. После завершения задача удаляется из qBittorrent без удаления скачанных файлов, а запись сохраняется в `data/history.json`. Проверка выполняется только для управляемой категории.

## Схема

```mermaid
flowchart LR
    T[Telegram] --> B[RPi 192.0.2.142\nliltorrent-bot.service]
    B -->|HTTP API 3000| L[Server2 203.0.113.10\nliltorrent.service]
    L -->|Web API 127.0.0.1:8080| Q[qBittorrent]
```

[[NETWORK|Карта сети]] · [[Bot sii]] · [[qBittorrent]]
