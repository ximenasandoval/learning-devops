# Installing Jenkins using Minikube
- Start Minikube
```
minikube start
```

- Create `jenkins` namespace
```
kubectl apply -f jenkins/jenkins-namespace.yml
```

- Create `jenkins` deployment
```
kubectl apply -f jenkins/jenkins-deployment.yml
```

- Create `jenkins` service
```
kubectl apply -f jenkins/jenkins-service.yml
```

# Access Jenkins
- Access using the url of the service we created above
```
minikube service jenkins -n jenkins --url
```
If it is the first time accessing Jenkins, you'll need the admin password, you can get if from the pod logs:
```
kubectl get pods -n jenkins
kubectl logs <pod name> -n jenkins
```

For more information, you can check [this documentation](https://www.jenkins.io/doc/book/installing/kubernetes/#install-jenkins-with-yaml-files)