---
tags: [сеть, сервис, веб, печать]
---

# Nginx

На [[VPS]] Nginx слушает TCP `80/443` для `greatprint.duckdns.org`. HTTP перенаправляет на HTTPS. На HTTPS включена Basic Auth, затем запросы идут к [[FRP]] на `127.0.0.1:18766`, а через него к [[CUPS]] на [[Eltex NV-501-WAC]]. Сертификат Let's Encrypt присутствует. [[NETWORK|Карта сети]]

Проверка публичного URL `/printers/Ricoh_SP150W` без учётных данных дала HTTP `401`; локальный запрос через FRP — `200`. Пароль Basic Auth в документации не хранится.
