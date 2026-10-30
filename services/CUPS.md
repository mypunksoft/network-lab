---
tags: [сеть, сервис, печать]
---
# CUPS

На [[Eltex NV-501-WAC]] `cupsd` работает внутри Ubuntu chroot и слушает TCP `631`. Проверены две включённые и простаивающие очереди: `Ricoh_SP150W` и `Ricoh_SP150W_Mobile`. Системная очередь по умолчанию не задана. [[NETWORK|Карта сети]]

Публичный доступ к основной очереди идёт через [[FRP]] и [[Nginx]] на [[VPS]]: `https://greatprint.duckdns.org/printers/Ricoh_SP150W`. Локальный запрос с VPS через FRP получил HTTP `200`.
