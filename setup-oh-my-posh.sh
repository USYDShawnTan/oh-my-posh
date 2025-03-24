#!/bin/bash

echo "👉 Installing oh-my-posh..."
curl -s https://ohmyposh.dev/install.sh | bash

# 设置主题配置目录
echo "📁 Creating theme config directory..."
mkdir -p ~/.poshthemes

# 下载自定义主题
echo "⬇️ Downloading your custom theme..."
curl -o ~/.poshthemes/my.omp.json https://raw.githubusercontent.com/USYDShawnTan/oh-my-posh/refs/heads/main/my.omp.json
chmod u+rw ~/.poshthemes/my.omp.json

# 确定使用的 shell
SHELL_NAME=$(basename "$SHELL")
if [[ "$SHELL_NAME" == "zsh" ]]; then
    CONFIG_FILE=~/.zshrc
elif [[ "$SHELL_NAME" == "bash" ]]; then
    CONFIG_FILE=~/.bashrc
else
    echo "⚠️ Unsupported shell: $SHELL_NAME. Please add oh-my-posh manually."
    exit 1
fi

# 自动添加 oh-my-posh bin 路径
if ! grep -q '\.local/bin' "$CONFIG_FILE"; then
    echo "🛠 Adding PATH export to $CONFIG_FILE"
    echo '' >> "$CONFIG_FILE"
    echo '# 👉 Add oh-my-posh to PATH' >> "$CONFIG_FILE"
    echo 'export PATH="$PATH:$HOME/.local/bin"' >> "$CONFIG_FILE"
fi

# 自动添加 oh-my-posh 初始化命令（新语法）
if ! grep -q 'oh-my-posh --init' "$CONFIG_FILE"; then
    echo "🛠 Adding oh-my-posh init command to $CONFIG_FILE"
    echo '' >> "$CONFIG_FILE"
    echo '# 👉 oh-my-posh initialization' >> "$CONFIG_FILE"
    echo "eval \"\$(oh-my-posh --init --shell $SHELL_NAME --config ~/.poshthemes/my.omp.json)\"" >> "$CONFIG_FILE"
fi

# 自动刷新配置
echo "🔄 Reloading $CONFIG_FILE..."
source "$CONFIG_FILE"

