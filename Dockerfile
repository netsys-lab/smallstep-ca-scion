FROM golang:1.18-alpine
WORKDIR /src
COPY . .
WORKDIR /src/cmd/step-ca
RUN CGO_ENABLED=0 go build

FROM alpine
RUN apk add --no-cache ca-certificates
COPY --from=0 /src/cmd/step-ca/step-ca /bin/step-ca
ENTRYPOINT ["step-ca"]