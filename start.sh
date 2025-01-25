#!/bin/bash
set -e

# 确保目录权限正确
chown -R www-data:www-data /var/git/repositories
chown -R www-data:www-data /var/cache/cgit

# 如果有额外的 cgit 配置文件，加载它们
if [ -d "/etc/cgitrc.d" ]; then
    for conf in /etc/cgitrc.d/*.conf; do
        if [ -f "$conf" ]; then
            cat "$conf" >> /etc/cgitrc
        fi
    done
fi

# 启动 supervisor
exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf