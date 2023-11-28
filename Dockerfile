FROM golang:latest as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download && go mod verify
COPY . .
RUN go build -o main .
RUN adduser -u 10001 chamnan

FROM scratch
WORKDIR /app
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /app/main .
EXPOSE 8080
USER chamnan
CMD [ "./main" ]