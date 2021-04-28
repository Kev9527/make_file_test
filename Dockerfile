FROM golang:1.16 AS buildstage

ENV GO111MODULE="on" 
ENV name Kaiwen
ARG timeZone
WORKDIR /hello
COPY /main \ go.mod \ svc /hello/
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -o main /hello/main/

ADD ./zoneinfo.zip /zoneinfo.zip
ENV TZ=CST ZONEINFO=/zoneinfo.zip

FROM ubuntu AS runstage
WORKDIR /root
COPY --from=buildstage /hello/main/main .


EXPOSE 8080
# CMD参数作为ENTRYPOINT的默认参数
CMD [ "-zone=shanghai" ]
ENTRYPOINT [ "./main" ]
