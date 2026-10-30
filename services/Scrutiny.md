---
tags: [сеть, сервис, мониторинг]
---

# Scrutiny

Мониторинг состояния дисков на [[Server2]]. Работает один Docker-контейнер `scrutiny` с образом `ghcr.io/analogj/scrutiny:master-omnibus`. Его внутренний порт `8080` опубликован на TCP `8081` всех адресов Server2. Веб-страница `/web/` отвечает и показывает Scrutiny. На хосте также активен `smartmontools`. [[NETWORK|Карта сети]]
