# Personal-Site

Cameron Hudson's personal website.
https://cameronhudson.info/

# How to build

docker build . -t gcr.io/personal-site-249505/github.com/cameronhudson8/personal-site/backend:

## How to deploy the first time

To install the cluster-wide ingress controller and cluster-wide default ingress backend, follow the directions at https://cloud.google.com/community/tutorials/nginx-ingress-gke. If helm and tiller are already installed on your PC and cluster, simply run

```
helm install \
  --name nginx-ingress \
  stable/nginx-ingress \
  --set rbac.create=true \
  --set controller.publishService.enabled=true
```

Then, create the namespaces and ingress resources. This is done on a per-namespace basis.
```
kubectl create namespace personal-site-dev \
  && kubectl create namespace personal-site-testing \
  && kubectl create namespace personal-site-staging \
  && kubectl create namespace personal-site-prod
kubectl apply -f ingresses/ingress-dev.yaml \
  && kubectl apply -f ingresses/ingress-testing.yaml \
  && kubectl apply -f ingresses/ingress-staging.yaml \
  && kubectl apply -f ingresses/ingress-prod.yaml
```

Set up the backend services.
```
kubectl -n personal-site-dev apply -f backend/backend-service.yaml \
  && kubectl -n personal-site-testing apply -f backend/backend-service.yaml \
  && kubectl -n personal-site-staging apply -f backend/backend-service.yaml \
  && kubectl -n personal-site-prod apply -f backend/backend-service.yaml
```

<!-- Set up the frontend services.
```
kubectl -n personal-site-dev apply -f frontend/frontend-service.yaml \
  && kubectl -n personal-site-testing apply -f frontend/frontend-service.yaml \
  && kubectl -n personal-site-staging apply -f frontend/frontend-service.yaml \
  && kubectl -n personal-site-prod apply -f frontend/frontend-service.yaml
``` -->

Set up the backend deployments.
```
kubectl -n personal-site-dev apply -f backend/backend-deployment.yaml \
  && kubectl -n personal-site-testing apply -f backend/backend-deployment.yaml \
  && kubectl -n personal-site-staging apply -f backend/backend-deployment.yaml \
  && kubectl -n personal-site-prod apply -f backend/backend-deployment.yaml
```

<!-- Set up the frontend deployments.
```
kubectl -n personal-site-dev apply -f frontend/frontend-deployment.yaml \
  && kubectl -n personal-site-testing apply -f frontend/frontend-deployment.yaml \
  && kubectl -n personal-site-staging apply -f frontend/frontend-deployment.yaml \
  && kubectl -n personal-site-prod apply -f frontend/frontend-deployment.yaml
``` -->

Finally, create the secrets for TLS certificates. First, copy the existing secret files.
```
cp certificates/tls-cameronhudson.info-secret-example.yaml certificates/tls-cameronhudson.info-secret.yaml \
  && cp certificates/tls-cameronhudson8.com-secret-example.yaml certificates/tls-cameronhudson8.com-secret.yaml
```

Next, encode the `.crt` and `.key` certificate files to base 64.
```
base64 cameronhudson.info.crt
base64 cameronhudson.info.key
base64 cameronhudson8.com.crt
base64 cameronhudson8.com.key
```

Place the base 64-encoded output into the respective secret file at the line indicated with the file.

Then, create the secrets in Kubernetes.
```
kubectl apply -f certificates/tls-cameronhudson.info-secret.yaml \
  && kubectl apply -f certificates/tls-cameronhudson-secret.yaml
```

## How to deploy sustainably

After this initial setup, you will need to set up build triggers and build instruction files.
This depends on the cloud provider. For Google, it's `cloudbuild.yaml`. Make one build
instruction file per image, per namespace.

You could also roll your own Jenkins pods and use `Jenkinsfile`s, but I have not learned
that yet.