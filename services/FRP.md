---
tags: [сеть, сервис, печать, туннель]
---

# FRP

FRP обслуживает [[CUPS]] и [[LilGit]] через [[VPS]]. На Eltex работает `frpc` с прокси `eltex-cups`; на [[Server2]] работает отдельный `frpc` с прокси `lilgit-private-full`. Оба клиента подключаются к `203.0.113.10:7000`. На VPS `frps` предоставляет локальные порты `127.0.0.1:18766` для CUPS и `127.0.0.1:18765` для LilGit. [[Nginx]] обращается к порту CUPS; LilGit доступен через SSH-туннель к VPS. [[NETWORK|Карта сети]]

```mermaid
flowchart LR
    C["CUPS Eltex :631"] <-->|локально| FC[frpc]
    FC -->|"TCP/7000 через AXGATE"| FS[frps на VPS]
    G["LilGit Server2 :8765"] --> FG["frpc Server2"]
    FG -->|"TCP/7000 через AXGATE"| FS
    FS --> L["127.0.0.1:18766"]
    FS --> LG["127.0.0.1:18765"]
    L --> N["Nginx HTTPS"]
    LG --> SH["SSH-туннель на Windows"]
    classDef tunnel fill:#e0f2fe,color:#0f172a,stroke:#0284c7,stroke-width:2px;
    class FC,FG,FS,L,LG tunnel;
```

По описанию [[AXGATE 80D]] разрешает print-сегменту только это соединение и выполняет SNAT в `198.51.100.2`; [[OpenWrt]] отправляет его через `wanroute`. При проверке FRP-соединение было установлено, запрос к локальному порту VPS вернул HTTP `200`.
