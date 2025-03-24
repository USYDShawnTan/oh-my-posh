#!/bin/bash

# ⚙️ Step 1: 安装 oh-my-posh（使用 curl 安装最新版）
echo "👉 Installing oh-my-posh..."
curl -s https://ohmyposh.dev/install.sh | bash

# ⚙️ Step 2: 创建配置目录
echo "📁 Creating theme config directory..."
mkdir -p ~/.poshthemes

# ⚙️ Step 3: 下载你的自定义主题文件
echo "⬇️ Downloading your custom theme..."
curl -o ~/.poshthemes/my.omp.json https://raw.githubusercontent.com/USYDShawnTan/oh-my-posh/refs/heads/main/my.omp.json

# ⚙️ Step 4: 设置权限
chmod u+rw ~/.poshthemes/my.omp.json

# ⚙️ Step 5: 自动添加到 shell 配置文件
SHELL_NAME=$(basename "$SHELL")

if [[ "$SHELL_NAME" == "zsh" ]]; then
    CONFIG_FILE=~/.zshrc
elif [[ "$SHELL_NAME" == "bash" ]]; then
    CONFIG_FILE=~/.bashrc
else
    echo "⚠️ Unsupported shell: $SHELL_NAME. Please add oh-my-posh config manually."
    exit 1
fi

# 检查是否已添加
if ! grep -q 'oh-my-posh init' "$CONFIG_FILE"; then
    echo "🛠 Adding oh-my-posh init command to $CONFIG_FILE"
    echo "" >> "$CONFIG_FILE"
    echo "# 👉 oh-my-posh initialization" >> "$CONFIG_FILE"
    echo 'eval "$(oh-my-posh init '"$SHELL_NAME"' --config ~/.poshthemes/my.omp.json)"' >> "$CONFIG_FILE"
else
    echo "✅ oh-my-posh already configured in $CONFIG_FILE"
fi

echo "🎉 Done! Please restart your terminal or run: source $CONFIG_FILE"
