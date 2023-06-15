#!/bin/bash

if [[ $(minikube status -o json | yq '.Host') != "Running" ]]; then
    echo Starting minikube 
    minikube start
else
    echo Minikube is already up
fi

echo Loading env variables
export $(cat assignment-3/docker-worker/.env | xargs)
unset AWS_PROFILE

echo Recreating ECR secrets

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

echo Unseal Vault pods

VAULT_UNSEAL_KEY=$(jq -r ".unseal_keys_b64[]" assignment-2/vault/cluster-keys.json)
kubectl exec vault-0 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl exec -ti vault-1 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY
kubectl exec -ti vault-2 -n vault -- vault operator unseal $VAULT_UNSEAL_KEY

echo Restarting radio deployment
kubectl rollout restart deployment/radio

echo 
echo Useful commands
echo 

echo - Start ArgoCD port forwarding
echo kubectl port-forward svc/argocd-server -n argocd 8080:443
echo 

echo - Get ArgoCD admin secret
echo kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d; echo
echo 

echo - Get Jenkins url
echo minikube service jenkins -n jenkins --url
echo 

echo - Get Jenkins admin secret
echo kubectl exec --namespace jenkins -it svc/jenkins -c jenkins -- /bin/cat /run/secrets/additional/chart-admin-password && echo
echo 

echo - Access sample-app in localhost:5000
echo minikube tunnel
echo 

echo - Access Vault UI
echo kubectl port-forward service/vault -n vault 8200:8200
echo

echo - Get Vault token
echo cat assignment-2/vault/cluster-keys.json | yq '.root_token'
echo 