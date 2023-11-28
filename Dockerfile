FROM golang:latest as builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download && go mod verify
COPY . .
RUN go build -o main .

FROM scratch
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
RUN adduser -u 10001 --disabled-password --gecos '' chamnan
USER chamnan
CMD [ "./main" ]