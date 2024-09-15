#!/bin/sh

# 设置 /var/www/html 的权限
chown -R www-data:www-data /var/www/html

# 启动 Apache
echo "Starting Apache..."
apache2-foreground
if [ $? -ne 0 ]; then
    echo "Failed to start Apache"
    exit 1
fi

# 保持容器运行
tail -f /dev/null