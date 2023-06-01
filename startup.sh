#!/bin/bash

if [[ $(minikube status -o json | yq '.Host') != "Running" ]]; then
    echo Starting minikube 
    minikube start
else
    echo "Minikube is already up"
fi

echo "Recreating regcred secrets"
echo "Loading env variables"
export $(cat assignment-3/docker-worker/.env | xargs)
unset AWS_PROFILE

echo "Recreating ECR secrets"

kubectl delete secret regcred -n default
kubectl delete secret regcred -n jenkins

kubectl create secret docker-registry regcred \
    --docker-server=https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password) \
    --namespace=default

kubectl create secret docker-registry regcred \
    --docker-server=https://${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com \
    --docker-username=AWS \
    --docker-password=$(aws ecr get-login-password) \
    --namespace=jenkins

echo ""
echo "Useful commands"
echo ""

echo "- Start ArgoCD port forwarding"
echo "kubectl port-forward svc/argocd-server -n argocd 8080:443"
echo ""

echo "- Get ArgoCD admin secret"
echo "kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo"
echo ""

echo "- Get Jenkins url"
echo "minikube service jenkins -n jenkins --url"
echo ""

echo "- Get Jenkins admin secret"
echo "kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo"
echo ""

echo "- Access sample-app in localhost:5000"
echo "minikube tunnel"
echo ""