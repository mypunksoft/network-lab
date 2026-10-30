---
aliases: [Карта сети, Домашняя сеть]
tags: [сеть, карта]
---

# Карта сети

Состояние на 26 октября 2026 года. [[OpenWrt]], [[Server1 Banana Pi]], [[Raspberry Pi 5]], [[Server2]], [[Eltex NV-501-WAC]] и [[VPS]] проверены по SSH; [[AXGATE 80D]] — через CLI. Пароли, ключи и токены здесь не хранятся.

## Устройства

```mermaid
flowchart LR
    NET((Интернет)) --> O["OpenWrt<br/>192.0.2.1"]
    O --> LAN["LAN<br/>192.0.2.0/24"] --> B["Server1 Banana Pi · Caddy<br/>192.0.2.152"]
    LAN --> R["Raspberry Pi 5 · приложения<br/>192.0.2.142"]
    O <-->|"transit 198.51.100.0/30"| A["AXGATE 80D<br/>198.51.100.2"]
    A --> T["trust<br/>203.0.113.0/24"] --> S["Server2<br/>203.0.113.10"]
    A --> P["print<br/>198.18.30.0/24"] --> E["Eltex<br/>198.18.30.10"]
    A --> G["game<br/>198.18.40.0/24"] --> PS["PS4<br/>198.18.40.10"]
    A --> X["test<br/>198.18.20.0/24"]
    E -->|"FRP TCP/7000"| V["VPS<br/>203.0.113.10"]
    NET -->|"HTTPS"| V
    classDef router fill:#2563eb,color:#fff,stroke:#1e40af,stroke-width:2px;
    classDef firewall fill:#7c3aed,color:#fff,stroke:#5b21b6,stroke-width:2px;
    classDef server fill:#059669,color:#fff,stroke:#047857,stroke-width:2px;
    classDef segment fill:#e0e7ff,color:#1e293b,stroke:#94a3b8;
    class O router;
    class A firewall;
    class B,R,S,E,V server;
    class LAN,T,P,G,X segment;
```

[[OpenWrt]] · [[Server1 Banana Pi]] · [[Raspberry Pi 5]] · [[AXGATE 80D]] · [[Server2]] · [[Eltex NV-501-WAC]] · [[VPS]] · [[Сегменты сети]]

## Сводка узлов

| Узел | Роль | Что доступно на сетевом интерфейсе | Что остаётся локальным |
| --- | --- | --- | --- |
| [[OpenWrt]] | Основной роутер, WireGuard, DNS/DHCP | SSH, LuCI, DNS/DHCP; `ttyd` только на LAN | Системные службы управления маршрутами и firewall |
| [[Server1 Banana Pi]] | Внутренний веб-прокси | Caddy, SSH | DNS `*.example.test` указывает сюда; приложения перенесены на Raspberry Pi |
| [[Raspberry Pi 5]] | Приложения и панель управления | Home Assistant, Guacamole, Mosquitto, Vaultwarden, Cockpit, Telegram-бот, SSH | `liltorrent-bot.service` управляет LilTorrent на Server2; MariaDB и `guacd` внутри Docker; Caddy остаётся на Banana Pi |
| [[AXGATE 80D]] | Межсетевой экран и маршрутизатор сегментов | Панель `:17877`, CLI `:2323`, интерфейсы зон | Обработка политик и NAT внутри устройства |
| [[Server2]] | Файлы, загрузки, мониторинг дисков | SSH, Samba, Fileshare, qBittorrent, LilTorrent, Scrutiny | `liltorrent.service` слушает TCP `3000`; Docker/containerd и системные службы |
| [[Eltex NV-501-WAC]] | Принт-сервер | SSH и CUPS | FRP-клиент инициирует исходящий туннель к VPS |
| [[VPS]] | Публичный вход к печати и другие внешние сервисы | Nginx, FRP, Icecast2, OpenVPN, SSH | FRP-порт CUPS `127.0.0.1:18766`; Icecast `127.0.0.1:8000` |

«Слушает сетевой интерфейс» означает привязку сервиса к адресу узла. Доступ между сегментами определяется firewall, а выход в интернет — маршрутизацией и NAT. Для Server1 статических port forward на OpenWrt не найдено; публичная доступность его сервисов не подтверждена.

## Сервисы

```mermaid
flowchart LR
    subgraph R[OpenWrt]
      WG[WireGuard и wanroute]
      DNS[DNS и DHCP]
      LU[LuCI / SSH]
    end
    subgraph B[Server1 · Banana Pi]
      CA[Caddy]
      BT[Bot sii]
    end
    subgraph RP[Raspberry Pi 5]
      HA[Home Assistant]
      VW[Vaultwarden]
      GU[Guacamole]
      MO[Mosquitto]
      CP[Cockpit]
      HA --> GO[go2rtc]
      CA --> HA
      CA --> VW
      CA --> GU
      CA --> CP
    end
    subgraph S[Server2]
      SMB[Samba]
      FS[Fileshare]
      QB[qBittorrent]
      SC[Scrutiny]
      LG[LilGit]
    end
    subgraph E[Eltex]
      C[CUPS]
      FC[frpc]
      C <--> FC
    end
    subgraph V[VPS]
      FR[frps]
      N[Nginx]
      I[Icecast2]
      OV[OpenVPN]
      FR --> N
    end
    FC -->|TCP 7000| FR
    CA -->|files.example.test| FS
    CA -->|lilgit.example.test| LG
    classDef service fill:#ecfeff,color:#0f172a,stroke:#06b6d4;
    class WG,DNS,LU,CA,HA,VW,GU,MO,CP,BT,GO,SMB,FS,QB,SC,LG,C,FC,FR,N,I,OV service;
    style R fill:#dbeafe,stroke:#3b82f6,stroke-width:2px
    style B fill:#dcfce7,stroke:#22c55e,stroke-width:2px
    style RP fill:#dcfce7,stroke:#22c55e,stroke-width:2px
    style S fill:#dcfce7,stroke:#22c55e,stroke-width:2px
    style E fill:#fef3c7,stroke:#f59e0b,stroke-width:2px
    style V fill:#fce7f3,stroke:#ec4899,stroke-width:2px
```

[[WireGuard и wanroute]] · [[DNS и DHCP]] · [[SSH]] · [[Caddy]] · [[Home Assistant]] · [[go2rtc]] · [[Vaultwarden]] · [[Guacamole]] · [[Mosquitto]] · [[Cockpit]] · [[Bot sii]] · [[Samba]] · [[Fileshare]] · [[qBittorrent]] · [[Scrutiny]] · [[LilGit]] · [[CUPS]] · [[FRP]] · [[Nginx]] · [[Icecast2]] · [[OpenVPN]]

В Obsidian откройте папку `net` как хранилище. В Graph view цветовые группы удобно настроить запросами `path:servers`, `path:services` и `path:network`. Ссылки между файлами формируют граф, а диаграммы Mermaid показываются прямо в заметке.
