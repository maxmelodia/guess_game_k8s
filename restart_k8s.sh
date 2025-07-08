#!/bin/bash

echo "🔁 Reiniciando ambiente Kubernetes local..."

echo "🧹 Deletando recursos anteriores..."
kubectl delete -f k8s/ --ignore-not-found=true

echo "🚀 Aplicando arquivos YAML novamente..."
kubectl apply -f k8s/

echo "⏳ Aguardando inicialização dos pods..."
sleep 10

echo "📦 Status dos pods:"
kubectl get pods

echo "🌐 Abrindo serviço frontend..."
minikube service frontend
