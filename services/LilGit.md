---
tags: [сеть, сервис, git]
---

# LilGit

Личный Git-сервер на [[Server2]] без аккаунтов. Код установлен в `/opt/lilgit/current`, конфиг — `/etc/lilgit/config.json`, данные и bare-репозитории — в `/mnt/lilgit-storage/lilgit`. Служба `lilgit.service` включена и слушает `203.0.113.10:8765`.

Внутри сети [[Caddy]] предоставляет `https://lilgit.example.test` через upstream `203.0.113.10:8765`. Для доступа с Windows через [[VPS]] служба `frpc.service` направляет LilGit на локальный порт VPS `127.0.0.1:18765`; задача Планировщика «LilGit SSH Tunnel» пробрасывает его на `http://127.0.0.1:18765` на основном компьютере. Порт VPS не опубликован на внешнем интерфейсе.

12 октября 2026 года HTTP `200` подтверждён на самом Server2, с Server1 через Caddy, на локальном FRP-порту VPS, а также через оба адреса с основного компьютера. На момент настройки каталог `repos` был пуст.

Резервные копии прежних конфигов: `/etc/lilgit/config.json.bak-20261012`, `/etc/frp/frpc.toml.bak-20261012` на Server2 и `/etc/caddy/Caddyfile.bak-20261012-lilgit` на Server1.
