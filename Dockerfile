FROM docker.io/library/golang:1.11.1 as builder
LABEL maintainer="maintainer@cilium.io"
ADD . /go/src/github.com/manojbadam/cilium-etcd-operator
WORKDIR /go/src/github.com/manojbadam/cilium-etcd-operator
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o main
RUN strip main

FROM scratch
LABEL maintainer="manojbadam88@gmail.com"
COPY --from=builder /go/src/github.com/manojbadam/cilium-etcd-operator/main /usr/bin/cilium-etcd-operator
WORKDIR /
CMD ["/usr/bin/cilium-etcd-operator"]
