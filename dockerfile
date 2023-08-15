FROM golang:1.20-alpine

RUN apk --no-cache add curl
RUN mkdir /build
RUN mkdir /out
RUN mkdir /proto
VOLUME /out

COPY proto /proto

ENV PROTOC_ZIP=protoc-3.14.0-linux-x86_64.zip
RUN curl -OL https://github.com/protocolbuffers/protobuf/releases/download/v3.14.0/$PROTOC_ZIP
RUN unzip -o $PROTOC_ZIP -d /build/local bin/protoc
RUN unzip -o $PROTOC_ZIP -d /build/local 'include/*'
RUN rm -f $PROTOC_ZIP

RUN go install google.golang.org/protobuf/cmd/protoc-gen-go@latest

CMD /build/local/bin/protoc -I=/proto --go_out=/out /proto/addressbook.proto

