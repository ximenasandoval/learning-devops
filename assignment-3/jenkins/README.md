# Installing Jenkins using Minikube
- Start Minikube
```
minikube start
```
- Create `jenkins` namespace
```
kubectl apply -f jenkins-namespace.yml
```

- Install Jenkins via Helm
```
helm repo add jenkins https://charts.jenkins.io
helm repo update
helm install jenkins jenkins/jenkins -n jenkins
```

- Create service
```
kubectl apply -f jenkins-service.yml
```

- Get admin password
```
kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
```

# Access Jenkins
- Access using the url of the service we created above
```
minikube service jenkins -n jenkins --url
```

# Access Jenkins container
```
eval $(minikube docker-env)
docker ps | grep jenkins
```