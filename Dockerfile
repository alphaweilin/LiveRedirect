FROM golang:1.19-alpine AS build

RUN go env -w GO111MODULE=on
RUN go env -w GOPROXY=https://goproxy.cn,direct

WORKDIR /app

COPY ./Golang/ ./
RUN go mod download
RUN go build -o /allinone

FROM alpine:3.14

COPY --from=build /allinone /allinone

EXPOSE 35455

ENTRYPOINT [ "/allinone" ]
