#!/bin/bash
# usage: ./upload_cos.sh <设备型号> <固件文件>
set -e


DEVICE_MODEL=$1
FIRMWARE_FILE=$2

# 参数检查
if [[ -z "$DEVICE_MODEL" || -z "$FIRMWARE_FILE" ]]; then
  echo "用法: $0 <设备型号> <固件文件>"
  echo "示例: $0 ESP32-S3 ./ESP32-S3-1.2.3-SNAPSHOT-20250114023841.bin"
  exit 1
fi

if [[ ! -f "$FIRMWARE_FILE" ]]; then
  echo "错误：文件 $FIRMWARE_FILE 不存在！"
  exit 2
fi


# 第二步：上传
REMOTE_PATH="embedded/${DEVICE_MODEL}/snapshots/$(basename "$FIRMWARE_FILE")"
echo "====== 开始上传 ======"
echo "本地文件 : $FIRMWARE_FILE"
echo "远程路径 : cos://${COS_BUCKET}/${REMOTE_PATH}"

coscmd upload "$FIRMWARE_FILE" "$REMOTE_PATH"

echo "====== 上传完成 ======"
