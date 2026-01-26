[control_plane]
k8s-control ansible_host=${control_ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa

[workers]
%{ for idx, ip in worker_ips ~}
k8s-worker-${idx + 1} ansible_host=${ip} ansible_user=ubuntu ansible_ssh_private_key_file=~/.ssh/id_rsa
%{ endfor ~}

[k8s-cluster:children]
control_plane
workers