---
tags: [сеть, сервис, mqtt]
---

# Mosquitto

Контейнер `mosquitto` на [[Raspberry Pi 5]] использует образ `eclipse-mosquitto:2.0`. MQTT опубликован на TCP `1883`, MQTT через WebSocket — на TCP `9001`; оба порта слушают сетевые интерфейсы Raspberry Pi. Home Assistant подключается к брокеру `192.0.2.142:1883`. Список клиентов и правила аутентификации не проверялись. [[NETWORK|Карта сети]]
