#!/bin/bash
set -e

git-crypt unlock

gcloud auth activate-service-account --key-file=secrets/gcloud-service-key.json
gcloud --quiet config set project g-gke-clusters
gcloud --quiet config set project us-central1-a

NETWORK_EXISTS=$(gcloud compute networks list --project "g-gke-clusters" --filter "name=dev-playground-network" --format "value(name)")
if [[ $NETWORK_EXISTS == "" ]]; then
  gcloud compute networks create "dev-playground-network" --project "g-gke-clusters"
else
  echo "Network already exists"
fi

CLUSTER_EXISTS=$(gcloud container clusters list --project "g-gke-clusters" --filter "name=dev-playground" --format "value(name)")
if [[ $CLUSTER_EXISTS == "" ]]; then
  gcloud container clusters create "dev-playground" \
    --enable-autorepair \
    --machine-type=n1-standard-1 \
    --num-nodes=3 \
    --network="dev-playground-network" \
    --project "g-gke-clusters" \
    --zone "us-central1-a"
    else
      echo "Cluster already exists"
    fi
