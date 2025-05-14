#!/bin/bash

# 设置工作目录为你的 Git 仓库路径
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


# git pull

# 获取远程最新代码（不自动合并）
git fetch origin

# 获取本地和远程 main 分支的 commit hash
LOCAL_MAIN=$(git rev-parse main)
REMOTE_MAIN=$(git rev-parse origin/main)

# 比较是否有新提交
if [ "$LOCAL_MAIN" != "$REMOTE_MAIN" ]; then

    git diff --name-only "$LOCAL_MAIN" "$REMOTE_MAIN" > ssupdated_files.txt
    
    echo "🔄 main 分支有更新，正在拉取最新代码..."
    git pull origin main
    
    # 拷贝更新的文件到远程服务器
    while IFS= read -r file; do
        if [[ "$file" == code* ]]; then
            echo "当前更新文件为 -> ${file}"
        else
            echo "跳过文件 -> ${file} (不符合条件)"
        fi
    done < ssupdated_files.txt
    
	php start.php stop
	
	php start.php start -d
	
else
    echo "✅ main 分支已是最新，无需更新。"
fi
