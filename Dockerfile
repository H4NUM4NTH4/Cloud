FROM golang:1.26.3 AS builder
WORKDIR /app
COPY go.mod ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o myredis .

FROM alpine:3.19
WORKDIR /app
COPY --from=builder /app/myredis .
EXPOSE 7379
CMD ["./myredis"]