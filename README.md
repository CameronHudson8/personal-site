# Personal-Site

Cameron Hudson's personal website.
https://cameronhudson8.com/

## How to install

**Assumptions:**
* You already have a Kubernetes cluster running.
* The cluster has an nginx ingress controller running in it. If not, see [these instructions](https://cloud.google.com/community/tutorials/nginx-ingress-gke) to set one up.
* The cluster has tiller installed. If not, see the aforementioned link.

```
kubectl create namespace personal-site
helm install ./personal-site --name personal-site --namespace personal-site
```

## How to remove

```
helm del personal-site
kubectl delete namespace personal-site
```

**TODO**: Since Jenkins is not yet set up, I manually granted permission for the GKE cluster on which this release runs, so that it can pull images from the container registry of an old project. My goal for commits to trigger a Jenkins build that will assemble an image, push it to the registry, and then deploy it in the same Kubernetes cluster.
