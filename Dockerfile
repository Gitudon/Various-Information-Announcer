
FROM golang:1.26.4-alpine
WORKDIR /usr/src/bot
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN go build -o main main.go
