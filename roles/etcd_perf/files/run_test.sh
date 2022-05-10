#!/usr/bin/env bash
set -e

cd /root/etcd-*/tools/benchmark || exit 1
go build
./benchmark put --cacert /etc/kubernetes/static-pod-certs/configmaps/etcd-peer-client-ca/ca-bundle.crt \
  --cert /etc/kubernetes/static-pod-certs/secrets/etcd-all-certs/etcd-peer-$(hostname).*crt \
  --key /etc/kubernetes/static-pod-certs/secrets/etcd-all-certs/etcd-peer-$(hostname).*key \
  --conns=100 --clients=200 --key-size=32 --sequential-keys --rate=4000 --total=240000 --val-size=1024 --target-leader

