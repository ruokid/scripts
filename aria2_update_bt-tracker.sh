#!/bin/sh
# 此脚本需要aria2服务端配置开启RPC功能
# aria2.conf add enable-rpc=true

# rpc更新配置
# curl -d '{"jsonrpc":"2.0","method":"aria2.changeGlobalOption","id":"cron","params":["token:'$passwd'",{"seed-time":"0"}]}' http://127.0.0.1:6800/jsonrpc --noproxy '*'

# 填写一个能够返回tracker地址列表的连接
trackerlist_url=${trackerlist_url-'https://cf.trackerslist.com/all.txt'}

# 设置curl代理，如果你不能访问trackerlist_url里的地址时，需要填写此项，并取消注释
# curl_proxy='-x socks5://127.0.0.1:1080'
trackerlist=$(curl ${curl_proxy} ${trackerlist_url}|tr -s '\n'|tr '\n' ',')

# 打印测试
# echo ${trackerlist%?}

# 填写你的aria2服务使用的RPC地址
aira2_rpc_url=${aira2_rpc_url-'http://127.0.0.1:6800/jsonrpc'}

# 将获取到的数据组合成特定格式
jsonrpc='{"jsonrpc":"2.0","method":"aria2.changeGlobalOption","id":"cron","params":["token:'${passwd}'",{"bt-tracker":"'${trackerlist%?}'"}]}'

# RPC请求
curl -d ${jsonrpc} ${aira2_rpc_url} --noproxy '*'
