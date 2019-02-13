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

#### 5.2.1. xqa-00
```
kubectl create -f xqa-00-db.yml
kubectl create -f xqa-00-message-broker.yml
```

#### 5.2.3. xqa-01
```
kubectl create -f xqa-01-shard.yml
```

#### 5.2.4. xqa-02
```
kubectl create -f xqa-02-db-amqp.yml
kubectl create -f xqa-02-ingest-balancer.yml
kubectl create -f xqa-02-query-balancer.yml
kubectl create -f xqa-02-query-ui.yml
```

### 5.3. Check Ports (internal & external)
* https://stackoverflow.com/questions/48857092/how-to-expose-nginx-on-public-ip-using-nodeport-service-in-kubernetes

* kubectl get ep --all-namespaces

```
kubectl --namespace=xqa get pods

kubectl --namespace=xqa describe services
```

#### 5.3.1. xqa-db
```
kubectl --namespace=xqa get svc xqa-db

psql -h <cluser ip|pod ip> -p 5432 -U xqa -d xqa
select * from events;
```

#### 5.3.2. xqa-message-broker
```
kubectl --namespace=xqa get svc xqa-message-broker
or
kubectl --namespace=xqa get ep

http://<cluser ip|pod ip>:8161/
```

#### 5.3.3. xqa-shard
```
????????????

basexclient ...
```

#### 5.3.4. xqa-query-ui
```
kubectl --namespace=xqa get svc xqa-query-ui
or
kubectl --namespace=xqa get ep

http://<cluser ip|pod ip>
```

### 5.4. Cleanup
```
kubectl delete -f xqa-02-db-amqp.yml
kubectl delete -f xqa-02-ingest-balancer.yml
kubectl delete -f xqa-02-query-balancer.yml
kubectl delete -f xqa-02-query-ui.yml
kubectl delete -f xqa-01-shard.yml
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

=============

increase Mi values + also how to scale if CPU / RAM exceeded?

how to use promethias

Check persistantvolume been created, kill something and check it comes back up

is pv bit enough for all pods?

create a pv for messagebroker.

create a pv for xqa-shard
= ensure that the pv isn't shared!
    = that when a xqa-shard goes down it comes back with it's own data
= how to autoscale xqa-shard?
    = size

---

Body = 50
https://www.ebay.co.uk/sch/i.html?_from=R40&_sacat=0&LH_Auction=1&_nkw=nikon%20d40%20body&LH_PrefLoc=1&LH_Complete=1&rt=nc&_trksid=p2045573.m1684

35mm = 70
https://www.ebay.co.uk/sch/i.html?_odkw=nikon+d40+body&LH_PrefLoc=1&LH_Auction=1&LH_Complete=1&_osacat=0&_from=R40&_trksid=p2045573.m570.l1311.R2.TR7.TRC0.A0.H2.Xnikon+af-s+35.TRS0&_nkw=nikon+af-s+35mm+f1.8+g+dx+lens&_sacat=0

18-55mm = 55
https://www.ebay.co.uk/sch/i.html?_odkw=nikon+af-s+35mm+f1.8+g+dx+lens&LH_PrefLoc=1&LH_Auction=1&LH_Complete=1&_osacat=0&_from=R40&_trksid=p2045573.m570.l1311.R3.TR7.TRC0.A0.H1.Xnikon+af-s+18-55.TRS0&_nkw=nikon+af-s+dx+nikkor+18-55mm&_sacat=0

55 - 200mm = 70
https://www.ebay.co.uk/sch/i.html?_odkw=nikon+af-s+dx+nikkor+18-55mm&LH_PrefLoc=1&LH_Auction=1&LH_Complete=1&_osacat=0&_from=R40&_trksid=p2045573.m570.l1311.R3.TR6.TRC1.A0.H2.Xnikon+af-s+dx+nikkor+55.TRS0&_nkw=nikon+af-s+dx+nikkor+55-200mm&_sacat=0

sony professional tape recorder wm-dc6 = 130
https://www.ebay.co.uk/sch/i.html?_odkw=sony+professional+tape+recorder&LH_PrefLoc=1&LH_Auction=1&LH_Complete=1&_osacat=0&_from=R40&_trksid=m570.l1313&_nkw=sony+professional+tape+recorder+wm-dc6&_sacat=0

---

