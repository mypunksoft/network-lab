---
tags: [сеть, сервис, администрирование]
---
# Cockpit

На [[Raspberry Pi 5]] активен `cockpit.socket` и слушает TCP `9090`; [[Caddy]] на [[Server1 Banana Pi]] проксирует веб-панель по имени `stat.example.test` на `https://192.0.2.142:9090`. Локальная проверка дала HTTP `200`. [[NETWORK|Карта сети]]

На [[Server2]] установлен Cockpit Machines для [[Виртуализация|управления виртуальными машинами]]. Внутренний адрес через [[Caddy]] — `https://vm.example.test/`; DNS `/hl/192.0.2.152` направляет его на Banana Pi, Caddy проксирует `https://203.0.113.10:9090`. Проверка с ноутбука дала HTTP `200` с доверенной внутренней цепочкой сертификата; `curl.exe` потребовал `--ssl-no-revoke`, поскольку проверка отзыва у локального CA недоступна. Прямой адрес `https://203.0.113.10:9090` также доступен.

После включения Server2 вход через `vm.example.test` показывал ошибку подключения, хотя прямой адрес работал. В журнале Cockpit было `received request from bad Origin: https://vm.example.test`. В `/etc/cockpit/cockpit.conf` добавлен `[WebService] Origins = https://vm.example.test wss://vm.example.test https://203.0.113.10:9090 wss://203.0.113.10:9090`; после перезапуска `cockpit.socket` и `cockpit.service` WebSocket через `vm.example.test` отвечает `101 Switching Protocols`. Пользователь подтвердил, что панель открылась.

Вкладка обновлений сообщала `Cannot refresh cache whilst offline`, хотя DNS и HTTPS на Server2 работали. Сеть управляется `systemd-networkd`, а неиспользуемый NetworkManager считал все интерфейсы unmanaged и вводил PackageKit в состояние offline (`NetworkState=1`). После остановки NetworkManager и отдельного перезапуска PackageKit состояние стало online (`NetworkState=2`). NetworkManager и `NetworkManager-wait-online` отключены; NetworkManager также замаскирован от автоматического запуска.

PackageKit медленно собирает подробности большого списка обновлений: операция `get-update-detail` занимала 156–214 секунд. Вкладка Cockpit после ожидания открылась; пользователь увидел 178 доступных обновлений, в том числе 71 исправление безопасности. Пакеты не устанавливались.
