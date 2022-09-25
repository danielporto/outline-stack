ARG TRAEFIK_BASE=v2.6.1
FROM traefik:${TRAEFIK_BASE}
ARG DEPLOYMENT_TYPE="dev"
ENV DEPLOYMENT_TYPE=${DEPLOYMENT_TYPE}

# fix vulnerability  https://snyk.io/vuln/SNYK-ALPINE311-APKTOOLS-1534687
RUN apk add --no-cache --upgrade apk-tools bash
COPY ./entrypoint.sh /90-entrypoint.sh

COPY ./configs /configs

ENTRYPOINT [ "/90-entrypoint.sh" ]
CMD ["traefik"]