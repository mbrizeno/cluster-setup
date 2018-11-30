#!/bin/bash
set -e

git-crypt unlock

gcloud auth activate-service-account --key-file=secrets/gcloud-service-key.json
gcloud --quiet config set project g-gke-clusters
gcloud --quiet config set project us-central1-a

gcloud container clusters get-credentials "dev-playground" --project "g-gke-clusters" --zone "us-central1-a"
# Ignore error if role binding already exists with || true
kubectl create clusterrolebinding cluster-admin-binding --clusterrole=cluster-admin \
  --user="$(gcloud config get-value core/account)" || true
kubectl config set-context "$(kubectl config current-context)" --namespace=default
kubectl apply -f istio-1.0.3/istio-demo-auth.yaml
