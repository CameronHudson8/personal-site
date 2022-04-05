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
