FROM golang:latest as builder
WORKDIR /app
COPY . .
RUN go mod download

FROM scratch
WORKDIR /app
COPY --from=builder /app/main .
EXPOSE 8080
RUN adduser -u 10001 --disabled-password --gecos '' chamnan
USER chamnan
CMD [ "./main" ]