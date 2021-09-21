# Personal-Site

Cameron Hudson's personal website.
https://cameronhudson8.com/

## How to install

**Assumptions:**
* You already have a Kubernetes cluster running.
* The cluster has an nginx ingress controller running in it. If not, see [these instructions](https://cloud.google.com/community/tutorials/nginx-ingress-gke) to set one up.

1. Build and push image:
    ```
    tag=$(git rev-parse --verify --short HEAD)
    docker build ./frontend/ -t "docker.io/cameronhudson8/personal-site-frontend:${tag}"
    docker push "docker.io/cameronhudson8/personal-site-frontend:${tag}"
    ```

1. Update the image tag in `./helm/values.yaml` with the value of `$tag`.

1. Deploy the application using `helm`. If necessary, create the namespace using `kubectl` first.
    ```
    kubectl create namespace <my-namespace>
    helm install personal-site ./helm \
        --kube-context <context> \
        --namespace <my-namespace> \
        --set-file crtChainFile=<path-to-crt-chain-file> \
        --set-file keyFile=<path-to-key-file>
    ```
