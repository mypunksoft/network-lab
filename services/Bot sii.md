---
tags: [сеть, сервис, бот]
---
# Telegram-бот

На [[Raspberry Pi 5]] `192.0.2.142` работает Python-бот `liltorrent-bot.service` от имени пользователя `portfolio`. Служба включена в автозапуск и настроена на автоматический перезапуск (`Restart=always`).

Бот:

- принимает `/wake` и публикует `ON` в MQTT `home/wol/send` для ESP;
- показывает `/status` таймера WoL;
- управляет LilTorrent на [[Server2]] через `http://203.0.113.10:3000`;
- поддерживает `/list`, `/history`, `.torrent`-файлы, magnet/HTTP-ссылки и inline-кнопки управления.

Слушающего TCP-порта у бота нет. MQTT-брокер работает отдельно в контейнере Mosquitto на этом же Raspberry Pi и слушает TCP `1883`.

Старый `botsii.service` от пользователя `pi` остановлен и не используется. [[NETWORK|Карта сети]]
