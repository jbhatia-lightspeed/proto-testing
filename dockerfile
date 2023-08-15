FROM golang:1.20

RUN apt-get update
RUN apt install -y unzip protobuf-compiler

RUN mkdir /build
RUN mkdir /out
RUN mkdir /proto
VOLUME /out

COPY proto /proto


RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest


CMD protoc -I=/proto --go_out=/out /proto/addressbook.proto

