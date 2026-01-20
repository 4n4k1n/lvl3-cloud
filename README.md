# lvl3-cloud

## Installation

1. Clone or download this repository
2. Create your `local.config.template` file (see example below)
3. Run the setup script:
```bash
chmod +x setup.sh
./setup.sh
```
## Container Diagram
```mermaid
C4Component
    title IaaS Foundations with OpenStack architecture diagram
    
    Container_Boundary(openstack, "OpenStack Services") {
        Component(keystone, "Keystone", "Identity")
        Component(nova, "Nova", "Compute")
        Component(neutron, "Neutron", "Network")
        Component(glance, "Glance", "Image")
        Component(cinder, "Cinder", "Block Storage")
        Component(placement, "Placement", "Resource Tracking")
    }
    
    Container_Boundary(infra, "Infrastructure") {
        ComponentDb(mysql, "MySQL", "State Storage")
        Component(rabbitmq, "RabbitMQ", "Message Queue")
        ComponentDb(etcd, "etcd", "KV Store")
    }
    
    Container_Boundary(hypervisor, "Virtualization") {
        Component(libvirt, "Libvirt/KVM", "Hypervisor")
        Component(ovs, "Open vSwitch", "Virtual Networking")
    }
    
    
    Rel(nova, keystone, "Authenticates")
    Rel(nova, rabbitmq, "Async Messaging")
    Rel(nova, mysql, "Persists State")
    Rel(nova, glance, "Fetches Images")
    Rel(nova, libvirt, "Manages VMs")
    Rel(neutron, ovs, "Configures Networks")
```
