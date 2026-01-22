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
    Horizon -->|auth| Keystone
    Horizon -->|compute API| Nova
    Horizon -->|image API| Glance
    Horizon -->|network API| QSvc
    Nova -->|auth| Keystone
    Nova -->|messaging| RabbitMQ
    Nova -->|data| MySQL
    Nova -->|images| Glance
    Nova -->|resources| Placement
    Nova -->|VMs| Libvirt
    QSvc -->|data| MySQL
    QSvc -->|messaging| RabbitMQ
    QAgt -->|flows| OVS
    QL3 -->|routing| OVS
    Glance -->|data| MySQL
    Placement -->|data| MySQL

    linkStyle 0 stroke:#FF0000
    linkStyle 1 stroke:#FF0000
    linkStyle 2 stroke:#FF0000
    linkStyle 3 stroke:#FF0000
    linkStyle 4 stroke:#FF0000
    linkStyle 5 stroke:#FF0000
    linkStyle 6 stroke:#FF0000
    linkStyle 7 stroke:#FF0000
    linkStyle 8 stroke:#FF0000
    linkStyle 9 stroke:#FF0000
    linkStyle 10 stroke:#FF0000
    linkStyle 11 stroke:#FF0000
    linkStyle 12 stroke:#FF0000
    linkStyle 13 stroke:#FF0000
    linkStyle 14 stroke:#FF0000
    linkStyle 15 stroke:#FF0000
    linkStyle 16 stroke:#FF0000
    linkStyle 17 stroke:#FF0000
    linkStyle 18 stroke:#FF0000
    linkStyle 19 stroke:#FF0000
    linkStyle 20 stroke:#FF0000
    linkStyle 21 stroke:#FF0000
    linkStyle 22 stroke:#FF0000
    linkStyle 23 stroke:#FF0000
    linkStyle 24 stroke:#FF0000
    linkStyle 25 stroke:#FF0000
```
