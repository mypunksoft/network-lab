---
tags: [сеть, сервис, файлы]
---

# Fileshare

На [[Server2]] активен `fileshare.service`. Он запускает `/usr/local/libexec/fileshare-guard.py`, который следит за каталогом `/mnt/disk1/file_server` и запускает Python-приложение `/home/portfolio/fileshare/fileshare.py`. HTTP-сервис слушает TCP `6574` и при локальной проверке ответил `200`. [[NETWORK|Карта сети]]

Назначение — выдача файлов из `/mnt/disk1/file_server`. Приложение не требует входа для просмотра, скачивания и загрузки; для файлов выбран отдельный каталог. Доступ между сегментами зависит от [[AXGATE 80D]]. С 12 октября 2026 года сервис доступен через [[Caddy]] по `https://files.example.test`; главная страница и `/upload` отвечают HTTP `200`.
