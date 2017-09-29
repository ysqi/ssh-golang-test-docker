FROM ysqi/gotestreport 

MAINTAINER ysqi <devysq@gmail.com>
 
# 安装工具
RUN apt-get -y update && apt-get install -y  git dnsutils


COPY pull.sh /app/coverage.sh
RUN chmod +x /app/coverage.sh

WORKDIR $GOPATH

ENTRYPOINT  /app/coverage.sh