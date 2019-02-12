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

kubectl get namespaces
```

### 5.2. Deploy
* cd xqa-documentaton/k8s

#### 5.2.1. xqa-db (internal ports exposed only)
```
kubectl create -f xqa-00-db.yml
```

#### 5.2.1. xqa-message-broker (internal ports exposed only)
```
kubectl create -f xqa-00-message-broker.yml
```

### 5.3. Check Ports (internal & external)
* https://stackoverflow.com/questions/48857092/how-to-expose-nginx-on-public-ip-using-nodeport-service-in-kubernetes

```
kubectl --namespace=xqa get pods

kubectl --namespace=xqa describe services
```

#### 5.3.1. xqa-db
```
kubectl --namespace=xqa get svc xqa-db-service

psql -h <cluser ip|pod ip> -p 5432 -U xqa -d xqa
select * from events;
```

#### 5.3.1. xqa-message-broker
```
kubectl --namespace=xqa get svc xqa-message-broker-service

http://<cluser ip|pod ip>:8161/
```

### 5.4. Cleanup
```
kubectl delete -f xqa-00-db.yml
kubectl delete -f xqa-00-message-broker.yml

kubectl delete namespace xqa
```

## 6. Teardown
```
sudo microk8s.reset

sudo microk8s.stop

sudo snap remove microk8s

snap unalias kubectl
```

## 7. Tutorials
* https://cloud.google.com/python/tutorials/bookshelf-on-kubernetes-engine