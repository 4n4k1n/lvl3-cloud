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
        CreateUser["Create stack user"]
        Start(["Start"])
        SetPerms["Set permissions"]
        AddSudo["Add to sudoers"]
        CloneRepos["Clone repos"]
        CopyConfig["Copy local.config"]
        Chown["Change ownership"]
        RunStack["Run stack.sh"]
        Tests{"Tests pass?"}
        Deploy["Deploy Services"]
        Error(["Failed"])
  end
 subgraph OpenStack["OpenStack Services"]
    direction TB
        Keystone["Keystone - Identity"]
        Nova["Nova - Compute"]
        Neutron["Neutron - Network"]
        Glance["Glance - Image"]
        Cinder["Cinder - Block Storage"]
        Placement["Placement - Resource Tracking"]
  end
 subgraph Infra["Infrastructure"]
    direction TB
        MySQL[("MySQL")]
        RabbitMQ["RabbitMQ"]
        Etcd[("etcd")]
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
    CopyConfig --> Chown
    Chown --> RunStack
    RunStack --> Tests
    Tests -- Yes --> Deploy
    Tests -- No --> Error
    Deploy --> Keystone & Nova & Neutron
    Nova --> Keystone & RabbitMQ & MySQL & Glance & Libvirt
    Neutron --> OVS & MySQL
    Glance --> MySQL
    Cinder --> MySQL

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
```
