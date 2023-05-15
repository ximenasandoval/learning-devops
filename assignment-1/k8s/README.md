# K8s deployment 

To deploy this app to Minikube, we will need to install it in our local
For MacOs:
```
brew install minikube
brew unlink minikube
brew link minikube
```
For Linux
```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

And start our mini cluster
```
minikube start
```

You can get a better view of the K8s resources with
```
minikube dashboard
```

# Create a deployment
```
kubectl apply -f radio-deployment.yml
```

# Create a minikube tunnel
```
minikube tunnel
```

# Create a service 
```
kubectl apply -f radio-service.yml
```