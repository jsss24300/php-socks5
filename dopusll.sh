#!/bin/bash

# 设置远程仓库地址和本地仓库路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# 获取远程更新
git fetch

# 判断是否有变更
if [ $(git rev-parse HEAD) != $(git rev-parse @{u}) ]; then
    echo "发现变更，正在更新文件..."
    git pull  # 根据你的主分支名称调整
	
	php start.php stop
	
	php start.php start -d

	
else
    echo "没有发现变更。"
fi
