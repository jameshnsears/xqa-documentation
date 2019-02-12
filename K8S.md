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

## 3. View Dashboard
```
# IP of dashboard
kubectl get all --all-namespaces | grep "service/kubernetes-dashboard"

# get token for login
kubectl -n kube-system get secret | grep "kubernetes-dashboard-token-"

# using: hex value - i.e. 95bt2
kubectl -n kube-system describe secret kubernetes-dashboard-token-95bt2
```
* visit https://10.152.183.137/#!/login

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
```
cd xqa-documentaton/k8s

kubectl create -f xqa-00-db.yml

kubectl --namespace=xqa get pods

psql -h 10.152.183.211 -p 5432 -U xqa -d xqa
select * from events;

```
* use dashboard to view artifacts.

### 5.3. Cleanup
```
kubectl delete namespace xqa
```

## 6. Teardown
```
sudo microk8s.reset

sudo microk8s.stop

snap unalias kubectl
```

https://kubernetes.io/docs/concepts/services-networking/service/
https://cloud.google.com/python/tutorials/bookshelf-on-kubernetes-engine