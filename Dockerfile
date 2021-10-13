FROM dart:2.14 AS builder

RUN apt-get update && apt-get install make && apt-get clean

WORKDIR /app

COPY . .
RUN pub get

RUN make generate_all

RUN dart compile exe bin/main.dart -o rdb

FROM scratch

COPY --from=builder /runtime/ /
COPY --from=builder /app/rdb /app/

ARG build
ENV BUILD_SHA=$build

ENTRYPOINT [ "/app/rdb" ]
