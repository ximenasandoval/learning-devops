# Installing ArgoCD in Minikube

Source: [mycloudjourney](https://mycloudjourney.medium.com/argocd-series-how-to-install-argocd-on-a-single-node-minikube-cluster-1d3a46aaad20) Medium article

- Create a new namespace
```
alias k=kubectl
k create namespace argocd
k get ns
```

- Install ArgoCD -- no HA
```
k apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

- Get initial admin secret
```
k -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
```

- Port forward to access the UI
```
k port-forward svc/argocd-server -n argocd 8080:443
```

# Configure a new app
WIP