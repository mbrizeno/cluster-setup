#!/bin/bash
set -euo

gcloud container clusters delete dev-playground --project "g-gke-clusters" --zone "us-central1-a"
