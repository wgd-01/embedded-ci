# !/usr/bin/env python
# -*- encoding:utf-8 -*-

import sys
import requests
import time
import os

JOB_URL = os.getenv("JOB_URL")
JOB_NAME = os.getenv("JOB_NAME")
BUILD_NUMBER = os.getenv("BUILD_NUMBER")
GIT_BRANCH = os.getenv("GIT_BRANCH")
BUILD_USER = os.getenv("BUILD_USER")

# currenttime = time.strftime("%Y-%m-%d %H:%M:%S", time.localtime())

url = 'https://open.feishu.cn/open-apis/bot/v2/hook/6521b95e-3d37-4e91-823f-379c774b0d8a'

method = 'post'

headers = {
    'Content-Type': 'application/json'
}

json = {
    "msg_type": "interactive",
    "card": {
        "config": {
            "wide_screen_mode": True,
            "enable_forward": True
        },
        "elements": [{
            "tag": "div",
            "text": {
                "content": "**构建分支**：" + GIT_BRANCH + "\n**构建用户**：" + BUILD_USER,
                "tag": "lark_md"
            }
        }, {
            "actions": [{
                "tag": "button",
                "text": {
                    "content": "下载固件",
                    "tag": "lark_md"
                },
                "url": os.getenv("DOWNLOAD_URL"),
                "type": "default",
                "value": {}
            }],
            "tag": "action"
        }],
        "header": {
            "title": {
                "content": "【" + JOB_NAME + "】构建完成",
                "tag": "plain_text"
            }
        }
    }
}
requests.request(method=method, url=url, headers=headers, json=json)
