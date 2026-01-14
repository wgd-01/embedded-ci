#!/bin/bash
# usage: ./rename_bin.sh <型号> <版本> [SNAPSHOT|RELEASE]

apt install -y g++
g++ main.c -pthread -O2 -o main.bin

set -e

MODEL=$1
VERSION=$2
#TYPE=SNAPSHOT        # 默认 SNAPSHOT
BIN_FILE="main.bin"

# 参数检查
if [[ -z "$MODEL" || -z "$VERSION" ]]; then
    echo "用法: $0 <型号> <版本> [SNAPSHOT|RELEASE]"
    echo "示例: $0 ESP32-S3 1.2.3"
    exit 1
fi

# 文件存在检查
if [[ ! -f "$BIN_FILE" ]]; then
    echo "错误：$BIN_FILE 不存在！"
    exit 2
fi

# 生成时间戳
TS=$(date +%Y%m%d%H%M%S)

# 组装新文件名
if [[ "$TYPE" == "RELEASE" ]]; then
    NEW_NAME="${MODEL}-${VERSION}.bin"
else
    NEW_NAME="${MODEL}-${VERSION}.bin"
fi

# 改名
mv "$BIN_FILE" "$NEW_NAME"

