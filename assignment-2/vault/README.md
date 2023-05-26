# Deploying Vault to Minikube

- Create `vault` namespace
```
alias k=kubectl
k apply -f vault-namespace.yml
```

## Installing Vault using Helm
```
helm repo add hashicorp https://helm.releases.hashicorp.com
helm repo update
helm search repo hashicorp/vault
```
```
cat > helm-vault-raft-values.yml <<EOF
server:
  affinity: ""
  ha:
    enabled: true
    raft: 
      enabled: true
EOF
```
- Install Vault Helm Chart
```
helm install vault hashicorp/vault --values helm-vault-raft-values.yml -n vault
```