# K8S
The document lists commands and instructions for running XQA inside Kubernetes on Ubuntu 18.04.

## 1. Install microk8s
```
sudo snap install microk8s --classic

sudo snap alias microk8s.kubectl kubectl

microk8s.enable dashboard registry istio
```

## 1.1. (optional) Install helm
```
wget https://storage.googleapis.com/kubernetes-helm/helm-v2.12.3-linux-amd64.tar.gz
```
* extract and place binaries into PATH

## 2. Start microk8s
```
sudo microk8s.start

# microk8s.enable ingress

microk8s.status
```

### 2.1. enable firewall
```
sudo ufw default allow routed
```

## 3. View Dashboard
```
# IP of dashboard
kubectl get all --all-namespaces | grep "service/kubernetes-dashboard"

# get token for login
kubectl -n kube-system get secret | grep "kubernetes-dashboard-token-"

# using: hex value - i.e. 95bt2
kubectl -n kube-system describe secret kubernetes-dashboard-token-<...>
```
* visit https://10.152.183.152/#!/login

## 4. (optional) Push XQA containers to local container registry
```
cd xqa-documentaton/k8s

./pull.sh

./tag.sh

./push.sh
```

## 5. Deploy XQA to K8S
### 5.1. Create Namespace
```
kubectl create namespace xqa
```

### 5.2. Deploy
* cd xqa-documentaton/k8s

```
kubectl create -f xqa-00-db.yml
kubectl create -f xqa-00-message-broker.yml
kubectl create -f xqa-01-shard.yml
kubectl create -f xqa-02-db-amqp.yml
kubectl create -f xqa-02-ingest-balancer.yml
kubectl create -f xqa-02-query-balancer.yml
kubectl create -f xqa-02-query-ui.yml

```

### 5.3. Services IP's / ports (internal & external)
```
# cluster IP's & ports for services
kubectl --namespace=xqa get svc

# pod IP's & ports
kubectl --namespace=xqa get ep
```

#### 5.3.1. xqa-db (serivce)
```
psql -h <cluster ip|pod ip> -p 5432 -U xqa -d xqa
select * from events;
```

#### 5.3.2. xqa-message-broker (serivce)
```
http://<cluster ip|pod ip>:8161/
```

#### 5.3.3. Populate xqa-shard's
```
# assuming xqa-test-data cloned
docker run --name="xqa-ingest" -v $HOME/GIT_REPOS/xqa-test-data:/xml jameshnsears/xqa-ingest:latest -message_broker_host <xqa-message-broker cluster ip|pod ip> -path /xml

docker rm -f xqa-ingest
```

#### 5.3.4. xqa-query-balancer (internal)
```
curl http://<xqa-query-balancer cluster ip|pod ip>:9090/xquery -X POST -H "Content-Type: application/json" -d '{"xqueryRequest":"count(/)"}'
```
#### 5.3.5. xqa-query-ui (service)
```
http://<cluster ip|pod ip>

NOTE: requires that "xqa-query-balancer" service IP in /etc/hosts
```

### 5.4. Cleanup
```
kubectl delete namespace xqa
```

## 6. Teardown
```
sudo microk8s.reset
or
sudo microk8s.stop

sudo snap remove microk8s

snap unalias kubectl
```

## 7. Misc.
* https://cloud.google.com/python/tutorials/bookshelf-on-kubernetes-engine

* http://127.0.0.1:8080/api/v1/namespaces/kube-system/services/monitoring-grafana/proxy

* https://github.com/dennyzhang/cheatsheet-kubernetes-A4

=============

1. test end to end
= need to specify as 

--

how to use promethias|grafana

increase Mi values + also how to scale if CPU / RAM exceeded?

Check persistantvolume been created, kill something and check it comes back up

is pv bit enough for all pods?

create a pv for messagebroker.

create a pv for xqa-shard
= ensure that the pv isn't shared!
    = that when a xqa-shard goes down it comes back with it's own data
= how to autoscale xqa-shard?
    = size

change xqa-shard so that uses a pv, and code picks up uuid (from pv) 
= so that comes back from the dead with same uuid
