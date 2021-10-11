FROM dart:2.14 AS builder

WORKDIR /app

COPY . .
RUN pub get

RUN make generate_all

RUN dart compile exe bin/main.dart -o app

FROM scratch

COPY --from=builder /runtime/ /
COPY --from=builder /app/app /app/

ARG build
ENV BUILD_SHA=$build

ENTRYPOINT [ "/app/app" ]
