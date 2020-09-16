# Install dependencies using composer
FROM golang:1.14.9-alpine3.12 AS build-stage
WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .
RUN go install

EXPOSE 80
CMD personal-site
