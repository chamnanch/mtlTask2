### builder ###
FROM golang:latest as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download && go mod verify
COPY *.go ./
RUN CGO_ENABLED=0 GOOS=linux go build -o /main
RUN adduser -u 10001 chamnan

### app image ###
FROM scratch
WORKDIR /app
COPY --from=builder /etc/passwd /etc/passwd
COPY --from=builder /main /main
EXPOSE 8080
USER chamnan
CMD [ "/main" ]