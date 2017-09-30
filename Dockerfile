FROM ysqi/gotestreport 

MAINTAINER ysqi <devysq@gmail.com>
 
# 安装工具
RUN apt-get -y update && apt-get install -y  git dnsutils


COPY coverage.sh /app/gocoverage.sh
RUN chmod +x /app/gocoverage.sh

WORKDIR $GOPATH

ENTRYPOINT  /app/gocoverage.sh
