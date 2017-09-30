#!/bin/bash

set -e

output() {
  color="32"
  if [[ "$2" -gt 0 ]]; then
    color="31"
  fi
  printf "\033[${color}m"
  echo $1
  printf "\033[0m"
} 

fail(){
    output "ERROR:$1"
    exit 1
}

# 如果不为空，则切换到当前路径
 if [ -n "$WORKDIR" ]; then
    mkdir -p "$WORKDIR"
    cd "$WORKDIR"
 fi 

# check


url=$GIT_REMTOE_URL
remtoeBanch=$GIT_REMOTE_BRANCH
private_key=$GIT_REMOTE_KEY

check() {
    if [ ! -n "$url" ]; then
        fail "GIT_REMTOE_URL can't empty"
    fi 

    if [ ! -n "$remtoeBanch" ]; then
        remtoeBanch="master"
        # fail "GIT_REMOTE_BRANCH can't empty"
    fi 
    
    # if [ ! -n "$private_key" ]; then
    #     fail "GIT_REMOTE_KEY can't empty"
    # fi 
}

savePrivateKey(){
    mkdir -p "${HOME}/.ssh/"

    host="$(echo "${url}" | sed -rn 's/git@(.*):(.*)\.git/\1/p')"   
    if [ ! -n "$host" ]; then
        fail "GIT_REMTOE_URL='${url}' 并不能从中提取到host，收接收的格式为:git@host:.*.git"
    fi   

    if [ -n "$private_key" ]; then
        id_rsa="${HOME}/.ssh/id_rsa" 
        echo "${private_key}" > "${id_rsa}"
        chmod 500 "${id_rsa}"
    fi
  
    ssh-keyscan -H $host >> ~/.ssh/known_hosts 
    ips="$(dig +short $host)" 
    while read -r ip; do 
        ssh-keyscan -H $host,$ip >> ~/.ssh/known_hosts
        ssh-keyscan -H $ip >> ~/.ssh/known_hosts  
    done <<< "${ips}" 
}
 

clone(){ 
    output "whill clone repo to current path: $(pwd)"
    git clone $url  ./
    git checkout $remtoeBanch
    output "current repor file list"
    ls -all 
}
 
check
output "check pass"

savePrivateKey
output "save private key successed"

clone
output "clone completed"

coverage