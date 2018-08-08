#!/bin/bash

set -e

KUBE_VERSION=v1.11.2
KUBE_PAUSE_VERSION=3.1
ETCD_VERSION=3.2.18
DNS_VERSION=1.14.8
CORE_VERSION=1.1.3
DASHBOARD_VERSION=v1.8.3
HEAPSTER_VERSION=v1.5.4
INFLUXDB_VERSION=v1.5.2
GRAFANA_VERSION=v5.0.4


GCR_URL=k8s.gcr.io
ALIYUN_URL=registry.cn-shenzhen.aliyuncs.com/cn-k8s

images=(kube-proxy-amd64:${KUBE_VERSION}
kube-scheduler-amd64:${KUBE_VERSION}
heapster-amd64:${HEAPSTER_VERSION}
kube-controller-manager-amd64:${KUBE_VERSION}
heapster-influxdb-amd64:${INFLUXDB_VERSION}
heapster-grafana-amd64:${GRAFANA_VERSION}
kube-apiserver-amd64:${KUBE_VERSION}
kubernetes-dashboard-amd64:${DASHBOARD_VERSION}
pause:${KUBE_PAUSE_VERSION}
etcd-amd64:${ETCD_VERSION}
coredns:$CORE_VERSION)


for imageName in ${images[@]} ; do
  docker pull $ALIYUN_URL/$imageName
  docker tag  $ALIYUN_URL/$imageName $GCR_URL/$imageName
  docker rmi $ALIYUN_URL/$imageName
done

docker images

