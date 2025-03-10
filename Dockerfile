FROM alpine:3.21.3 AS build

FROM scratch
ARG TARGETARCH
WORKDIR /
COPY --from=build /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
COPY "./bin/app-${TARGETARCH}" /app
ENTRYPOINT ["/app"]