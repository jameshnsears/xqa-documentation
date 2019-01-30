# K8S
The document lists commands and instructions for running XQA inside Kubernetes on Ubuntu 18.04.

## 1. Install microk8s
```
sudo snap install microk8s --classic

microk8s.enable dashboard registry istio

sudo microk8s.start

microk8s.status
```

## 2. View Dashboard
```
# IP of dashboard
microk8s.kubectl get all --all-namespaces | grep "service/kubernetes-dashboard"

# get token for login
microk8s.kubectl -n kube-system get secret | grep "kubernetes-dashboard-token-"

# using: hex value - i.e. 95bt2
microk8s.kubectl -n kube-system describe secret kubernetes-dashboard-token-95bt2
```
* visit https://10.152.183.46/#!/login

## 3. Push XQA containers to local container registry
```
xqa-documentaton/k8s/bin/tag-k8s.sh

xqa-documentaton/k8s/bin/push-k8s.sh
```

### 3.1. List local container registry
```
curl http://127.0.0.1:32000/v2/_catalog

curl -X GET http://127.0.0.1:32000/v2/v2/xqa-db/tags/list
```

## 4. Deploy XQA to K8S
```
cd xqa-documentation/k8s

microk8s.kubectl create -f deployment_xqa-db.yml
microk8s.kubectl create -f deployment_xqa-message-broker.yml

microk8s.kubectl get deployments
microk8s.kubectl describe deployments

microk8s.kubectl delete -f deployment_xqa-db.yml
microk8s.kubectl delete -f deployment_xqa-message-broker.yml

```

## 5. Teardown
```
sudo microk8s.reset

sudo microk8s.stop
```

https://kubernetes.io/docs/concepts/services-networking/service/
https://cloud.google.com/python/tutorials/bookshelf-on-kubernetes-engine