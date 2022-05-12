#!/bin/sh
#
# Remove all .DS_Store file
# author: cx
# 
# 使用方法：打开终端 -> 执行./rm.DS_Store.sh [可选文件夹路径]
# 例如：./rm.DS_Store.sh
#      ./rm.DS_Store.sh ~/Downloads
# 
# 禁止在连接的储存中创建 .DS_Store 文件
# defaults write com.apple.desktopservices DSDontWriteNetworkStores true
# 这个命令可以让你从Mac上远程访问别的文件夹时不会产生.DS_Store文件
# 如果想恢复就把最后的 true 改成 false
#

# Terminal work directory
twd=$(pwd)
# Script work directory
swd=$(cd $(dirname $0); pwd)

find ${1:-$swd} \
-path ~/Library -prune -o \
-name ".DS_Store" \
-exec rm {} \; \
-exec echo {} removed \;

# echo All .DS_Store have been removed"
echo "\033[32mAll .DS_Store have been removed\033[0m"
