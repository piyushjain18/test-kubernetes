#!/bin/bash

DRY_RUN="${DRY_RUN:-true}"

usage() {
  cat <<EOT
Usage:
  DRY_RUN=true ${0} NUM_OF_MANIFEST
Example:
  DRY_RUN=false ${0}  500
EOT
  exit 1
}

gen_manifest() {
  local n
  n="${1}"

  cat <<EOT
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: testdeployment
  name: testdeployment
  namespace: kouzoh-newcd-guinea-${n}-jp-lab
spec:
  replicas: 1
  selector:
    matchLabels:
      app: testdeployment
  strategy: {}
  template:
    metadata:
      labels:
        app: testdeployment
    spec:
      imagePullSecrets:
        - name: gcr-image-puller-service-account
      volumes:
        - name: gcp-pod-default-service-account
          secret:
            defaultMode: 420
            secretName: gcp-pod-default-service-account
      containers:
        - image: gcr.io/kouzoh-newcd-guinea-jp-lab/kouzoh-newcd-guinea-jp:main-2021090310033 # {"$imagepolicy": "flux-system:kouzoh-newcd-guinea-${n}-jp-lab-kouzoh-newcd-guinea-jp-root-imagepolicy"}
          name: kouzoh-newcd-guinea-jp

EOT
}

main() {

  local num_of_manifest="${1}"



  if [[ $# -lt 1 ]]; then
    usage
  fi

  local opts=()
  if [[ "${DRY_RUN}" == "true" ]]; then
    opts+=("--dry-run=server")
  fi

  for (( i=1; i <= num_of_manifest; i++)); do
     gen_manifest  "${i}" > microservices/kouzoh-newcd-guinea-jp/laboratory/deploy-to-laboratory-"${i}".yaml

  done
}

set -eo pipefail
main "$@"