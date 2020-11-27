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
docker build ./frontend/ -t "cameronhudson8/personal-site-frontend:${tag}"
docker push "cameronhudson8/personal-site-frontend:${tag}"
```

1. Update the image tag in `./helm/values.yaml` with the value of `$tag`.

1. Create certificate resource files. Examples are provided that you should copy in the following way.
```
(cd helm/templates/certificates/ && cp tls-cameronhudson.info-secret-example.yaml tls-cameronhudson.info-secret.yaml)
(cd helm/templates/certificates/ && cp tls-cameronhudson8.com-secret-example.yaml tls-cameronhudson8.com-secret.yaml)
```

1. Locate the TLS certificate(s) for your intended domain name(s). Each certificate will include a `crt` and a `key`. Encode each in base 64.
    ```
    cat 'my-certificate.crt' | base64
    cat 'my-certificate.key' | base64
    ```

1. Copy and paste the corresponding output into the certificate resource files.
    ```
    vim helm/templates/certificates/tls-cameronhudson.info-secret.yaml
    vim helm/templates/certificates/tls-cameronhudosn8.com-secret.yaml
    ```

1. Deploy the application using `helm`. If necessary, create the namespace using `kubectl` first.
    ```
    kubectl create namespace <my-namespace>
    helm install personal-site ./helm --namespace <my-namespace>
    ```

## How to remove

Remove the application using `helm`. If the namespace is not being used by anything else, you can remove it as well with `kubectl`.
```
helm del personal-site
kubectl delete namespace personal-site
```
