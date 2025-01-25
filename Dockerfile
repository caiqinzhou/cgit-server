FROM debian:bookworm-slim

# 安装必要的软件包
RUN apt-get update && apt-get install -y \
    nginx \
    fcgiwrap \
    cgit \
    git \
    highlight \
    apache2-utils \
    supervisor \
    python3-pygments \
    && rm -rf /var/lib/apt/lists/*

# 创建必要的目录
RUN mkdir -p /var/run/fcgiwrap \
    && chown www-data:www-data /var/run/fcgiwrap \
    && mkdir -p /var/git/repositories \
    && mkdir -p /var/cache/cgit \
    && chown -R www-data:www-data /var/git/repositories \
    && chown -R www-data:www-data /var/cache/cgit

# 复制配置文件
COPY cgitrc /etc/cgitrc
# COPY nginx.conf /etc/nginx/conf.d/default.conf
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
COPY start.sh /start.sh
RUN chmod +x /start.sh

# 暴露端口
EXPOSE 80

# 定义挂载点
VOLUME ["/var/git/repositories", "/etc/cgitrc.d"]

# 使用 supervisor 启动服务
CMD ["/start.sh"]


