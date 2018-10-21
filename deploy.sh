#!/bin/bash

rsync -va -e 'ssh -i ~/.ssh/Kronn8_id_rsa -l cameekvm -p 21098' --exclude-from=exclude-from-deploy /Users/cameronhudson/Repositories/Personal/Personal-Site/ cameekvm@server200.web-hosting.com:/home/cameekvm/