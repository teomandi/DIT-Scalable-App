# Infinite Scale 
Deploying and Scaling Laravel application on Kubernetes (k8s)

A project created for the Cloud-Computing subject (2019-2020)

## Setup the environment
### Start minikube

```
minikube start --driver=virtualbox
minikube status
minikube dashboard

kubectl config use-context minikube
```

### Create the docker-image

```
eval $(minikube docker-env)  # so the image can be created in space viewable from the minikube
cd in/the/project
docker build . -t  teo/scalable-app 
```

---

## Setup the Application
### Deploy on K8s

```
kubectl apply -f nginx_deployment.yaml 
kubectl apply -f nginx_service.yaml
kubectl apply -f nginx_configMap.yaml
kubectl apply -f php_deployment.yaml 
kubectl apply -f php_service.yaml
```

### Get the application URL:

```
minikube service nginx  # auto load

minikube service nginx --url  # for manual copy
```

### Error fixing: 
Because we are using busybox image in initContainer lifecycle event, this will not copy code from our image to volume because php container or pod is not yet created. So we might get forbidden or NOT FOUND error when we open our nginx service in browser, so we have to copy code manually to the `/code/scale-app/` directory

```
kubectl get pods
# login into the pod
kubectl exec -it scalable-app-<one random pod name> -- /bin/bash
# copy the app in the correct destination
cp -r /var/www/. /code/scalable-app
# fix some permissions
chown -R $USER:www-data storage/
chown -R $USER:www-data bootstrap/cache/
chmod -R 775 storage/
chmod -R 775 bootstrap/cache/
```

### Set the ingress

```
minikube addons enable ingress
kubectl apply -f ingress.yaml
kubectl describe ingress

```

Now the app can be found in the given <url>

### Set the horizontal app

```
minikube addons enable metrics-server
kubectl apply -f autoscaling.yaml
```

we can also do `kubectl apply -f ./` to set all the `.yaml` files simultaneously

---

### Clean up:

```
kubectl delete deployment scalable-app
kubectl delete service scalable-app
kubectl delete deployment nginx
kubectl delete service nginx
kubectl delete configmap nginx-config
kubectl delete ingress scalable-app
```

---

## Evaluation

Using the SIEGE 4.0.4
<info and setup instructions>

```
sudo apt-get update -y
sudo apt-get install -y siege

siege <url>  # usage
```
