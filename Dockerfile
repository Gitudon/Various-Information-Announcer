# --- Build Stage ---
FROM golang:1.26.4-alpine
WORKDIR /app

# 依存関係をキャッシュ
COPY go.mod go.sum ./
RUN go mod download

# ソースコードをコピーしてビルド
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o /mybot ./cmd/bot/main.go

# --- Deploy Stage ---
FROM alpine:latest
RUN apk --no-cache add ca-certificates
WORKDIR /root/

# ビルドされたバイナリだけをコピー
COPY --from=builder /mybot .

# 実行
CMD ["./mybot"]
