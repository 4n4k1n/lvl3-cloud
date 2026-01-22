# lvl3-cloud

## Installation

1. Clone or download this repository
2. Create your `local.config.template` file (see example below)
3. Run the setup script:
```bash
curl -L https://raw.githubusercontent.com/4n4k1n/lvl3-cloud/refs/heads/main/scripts/setup.sh | bash
```
## Container Diagram
```mermaid
flowchart TB
 subgraph Setup["Setup Script"]
    direction TB
        Start(["Start"])
        CreateUser["Create stack user"]
        SetPerms["Set permissions"]
        AddSudo["Add to sudoers"]
        CloneRepos["Clone repos"]
        CopyConfig["Copy local.conf"]
        RunStack["Run stack.sh"]
        Tests{"Tests pass?"}
        Deploy["Deploy Services"]
        Error(["Failed"])
  end
 subgraph UI["User Interface"]
    direction TB
        Horizon["Horizon - Dashboard"]
  end
 subgraph OpenStack["OpenStack Services"]
    direction TB
        Keystone["Keystone - Identity"]
        Nova["Nova - Compute"]
        Glance["Glance - Image"]
        Placement["Placement - Resource Tracking"]
  end
 subgraph Network["Neutron - Networking"]
    direction TB
        QSvc["q-svc - API Server"]
        QAgt["q-agt - OVS Agent"]
        QDhcp["q-dhcp - DHCP Agent"]
        QL3["q-l3 - L3 Agent"]
        QMeta["q-meta - Metadata Agent"]
  end
 subgraph Infra["Infrastructure"]
    direction TB
        MySQL[("MySQL")]
        RabbitMQ["RabbitMQ"]
  end
 subgraph Hypervisor["Virtualization"]
    direction TB
        Libvirt["Libvirt/KVM"]
        OVS["Open vSwitch"]
  end
    Start --> CreateUser
    CreateUser --> SetPerms
    SetPerms --> AddSudo
    AddSudo --> CloneRepos
    CloneRepos --> CopyConfig
    CopyConfig --> RunStack
    RunStack --> Tests
    Tests -- Yes --> Deploy
    Tests -- No --> Error
    Deploy -->|starts| Horizon
    Horizon -->|token auth| Keystone
    Horizon -->|manage instances| Nova
    Horizon -->|browse images| Glance
    Horizon -->|manage networks| QSvc
    Nova -->|validate tokens| Keystone
    Nova -->|RPC calls| RabbitMQ
    Nova -->|instance state| MySQL
    Nova -->|fetch images| Glance
    Nova -->|allocate CPU/RAM| Placement
    Nova -->|spawn VMs| Libvirt
    QSvc -->|network config| MySQL
    QSvc -->|agent RPC| RabbitMQ
    QAgt -->|bridge flows| OVS
    QL3 -->|NAT/routing| OVS
    Glance -->|image metadata| MySQL
    Placement -->|resource inventory| MySQL

    linkStyle 0 stroke:#FFFFFF
    linkStyle 1 stroke:#FFFFFF
    linkStyle 2 stroke:#FFFFFF
    linkStyle 3 stroke:#FFFFFF
    linkStyle 4 stroke:#FFFFFF
    linkStyle 5 stroke:#FFFFFF
    linkStyle 6 stroke:#FFFFFF
    linkStyle 7 stroke:#FFFFFF
    linkStyle 8 stroke:#FFFFFF
    linkStyle 9 stroke:#FFFFFF
    linkStyle 10 stroke:#FFFFFF
    linkStyle 11 stroke:#FFFFFF
    linkStyle 12 stroke:#FFFFFF
    linkStyle 13 stroke:#FFFFFF
    linkStyle 14 stroke:#FFFFFF
    linkStyle 15 stroke:#FFFFFF
    linkStyle 16 stroke:#FFFFFF
    linkStyle 17 stroke:#FFFFFF
    linkStyle 18 stroke:#FFFFFF
    linkStyle 19 stroke:#FFFFFF
    linkStyle 20 stroke:#FFFFFF
    linkStyle 21 stroke:#FFFFFF
    linkStyle 22 stroke:#FFFFFF
    linkStyle 23 stroke:#FFFFFF
    linkStyle 24 stroke:#FFFFFF
    linkStyle 25 stroke:#FFFFFF
```
