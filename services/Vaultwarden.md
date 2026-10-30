---
tags: [сеть, сервис, пароли]
---

# Vaultwarden

Контейнер `vaultwarden` на [[Raspberry Pi 5]] опубликован на `192.0.2.142:5173` для прокси Caddy. Для клиентов доступ идёт через [[Caddy]] на [[Server1 Banana Pi]] по внутреннему имени `vaultwarden.example.test` и HTTPS. Локальная проверка Caddy дала HTTP `200`. Образ контейнера: `vaultwarden/server:latest`. [[NETWORK|Карта сети]]

Секреты и содержимое хранилища не исследовались и не записаны в документацию.
