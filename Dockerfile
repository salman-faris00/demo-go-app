# Build stage
FROM golang:1.24 AS builder

WORKDIR /app
COPY . .
RUN go mod download

COPY . .
RUN go build -o app main.go

# Run stage
FROM alpine:latest
WORKDIR /root/
COPY --from=builder /app/app .

EXPOSE 8000
CMD ["./app"]