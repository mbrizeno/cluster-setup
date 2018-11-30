#!/bin/bash
set -e

gcloud container clusters delete dev-playground --project "g-gke-clusters" --zone "us-central1-a" --quiet
