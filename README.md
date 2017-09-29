
Docke Image Name: **sshgorepotest**

# Go项目测试分析

基于ssh获取项目，并对其执行自动测试与代码检查

+ go test
+ go lint
+ go vet

最终将检查结果生成报告文件，存放于`./cover`目录


# 运行参数


+ GIT_REMTOE_URL  项目地址，必须是git@host:.*.git格式
+ GIT_REMOTE_BRANCH （可选)分支
+ GIT_REMOTE_KEY  (可选)私钥内容，将利用此私钥下载项目

实例. env.file
```ini 
GIT_REMTOE_URL = git@github.com:ysqi/com
GIT_REMOTE_BRANCH = master
GIT_REMOTE_KEY = '......'
```
Docker运行方式：
```shell
export GIT_REMOTE_KEY="$(cat ~/.ssh/id_rsa)"
docker run -e GIT_REMOTE_KEY --env-file env.list -w /go/src/github.com/ysqi/com ysqi/sshprojecttest 
```
运行时必须设置`-w`，否则git clone 项目将在错误的位置。