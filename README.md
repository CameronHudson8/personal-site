# Personal-Site

Cameron Hudson's personal website.
https://cameronhudson.info
https://cameronhudson8.com

## How to deploy

1. Create a GCS bucket for use as a terraform backend.
    ```bash
    gsutil mb -l US gs://personal-site-tf-state
    ```

1. Enable versioning on the bucket.
    ```bash
    gsutil versioning set on gs://personal-site-tf-state
    ```

1. Create a default imagePullSecret and attach it to the default service account.
    ```
    SERVICE_ACCOUNT_ID=<service-account-id>  # for example, 'cameronhudson'
    SERVICE_ACCOUNT_JSON_KEY_FILE=<service-account-key-file>

    kubectl create secret docker-registry image-pull-secret \
        --context minikube \
        -n personal-site \
        --docker-server=https://us-west1-docker.pkg.dev \
        --docker-email="${SERVICE_ACCOUNT_ID}@cameronhudson8.iam.gserviceaccount.com" \
        --docker-username=_json_key \
        --docker-password="$(cat "$SERVICE_ACCOUNT_JSON_KEY_FILE")"

    kubectl patch serviceaccount default \
        --context minikube \
        -n personal-site \
        -p '{"imagePullSecrets": [{"name": "image-pull-secret"}]}'
    ```

1. Build the image.
    ```
    TAG="$(git rev-parse HEAD)"
    echo "$TAG"
    docker build \
        ./frontend \
        -t "us-west1-docker.pkg.dev/cameronhudson8/personal-site/frontend:${TAG}" \
        --platform=linux/amd64
    docker push "us-west1-docker.pkg.dev/cameronhudson8/personal-site/frontend:${TAG}"
    ```

1. Update the image tag in `variables.tf`.

1. Redeploy the application
    ```
    ENV_NAME='local'  # or 'prod'
    terragrunt apply --terragrunt-working-dir "./config/${ENV_NAME}"
    ```

1. Set your `/etc/hosts` file as shown below.
   ```
   127.0.0.1 local.cameronhudson.info
   127.0.0.1 local.cameronhudson8.com
   ```

1. Get the certificate contents and save it locally.
    ```
    for hostname in local.cameronhudson8.com local.cameronhudson.info; do
        kubectl get secret "tls-${hostname}" \
            -n personal-site \
            -o json \
            | jq -r '.data["tls.crt"]' \
            | base64 -d \
            >~/Desktop/${hostname}.pem
    done
    ```

1. Add each of the certificates to your `login` keychain. Then, inside Keychain Access, double-click on each certificate and set the trust level as "Always Trusted".

1. In a separate shell, start the minikube tunnel.
   ```
   minikube tunnel
   ```

1. Visit https://local.iskprinter.com to confirm that the page is visible and the certificate is trusted.