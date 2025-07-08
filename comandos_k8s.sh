#!/bin/bash

echo "Aplicando todos os manifests..."
kubectl apply -f k8s/

echo "Reiniciando o frontend..."
kubectl rollout restart deployment frontend
# kubectl rollout restart deployment backend
# kubectl rollout restart deployment postgres

# minikube service backend
# minikube service frontend