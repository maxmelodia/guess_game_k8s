#!/bin/bash

set -e  # para encerrar se algum comando falhar

# Função de pausa interativa
pause() {
  echo ""
  read -n 1 -s -r -p "👉 Pressione qualquer tecla para continuar..."
  echo ""
}

# Função de loading animado
loading() {
  local message=$1
  echo -n "$message"
  for i in {1..3}; do
    echo -n "."
    sleep 0.4
  done
  echo ""
}

# Cabeçalho
echo "🌐 SCRIPT DE DEPLOY DO GUESS GAME COM HELM + MINIKUBE"
echo "============================================="
pause

# Etapa 1: Uninstall Helm (caso exista)
loading "🧹 Removendo instalação anterior com Helm"
helm uninstall guess-game || echo "🔸 Nenhum release anterior encontrado."
pause

# Etapa 2: Limpando recursos residuais
loading "🧹 Limpando recursos antigos (Ingress, Service, Deployments)"
kubectl delete ingress guess-ingress --ignore-not-found
kubectl delete svc backend frontend --ignore-not-found
kubectl delete deploy backend frontend --ignore-not-found
pause

# Etapa 3: Instalando com Helm
loading "🚀 Instalando aplicação com Helm"
helm install guess-game k8s/guess-game-chart
pause

# Etapa 4: Verificando status
loading "🔍 Verificando recursos criados"
kubectl get all
kubectl get ingress
pause

# Etapa 5: Lembrete do túnel
echo ""
echo "📢 Agora você precisa abrir outro terminal e rodar:"
echo "   👉 minikube tunnel"
echo "🔗 Depois, acesse: http://guess.local"
pause

echo ""
echo "🎉 Tudo pronto! Boa sorte com o jogo 😎"
