# 使用 Ubuntu 20.04 作为基础镜像
FROM ubuntu:22.04

# 维护者信息
LABEL maintainer="your_email@example.com"
ENV DEBIAN_FRONTEND=noninteractive

# 更新软件包列表并安装必要的软件包
RUN sed -i 's@//.*.ubuntu.com@//mirrors.ustc.edu.cn@g' /etc/apt/sources.list && \
    echo "Asia/Shanghai" > /etc/timezone && \
    apt-get update && apt-get install -y \
    novnc \
    websockify \
    x11vnc \
    xvfb \
    supervisor \
    fluxbox \
    wget \
    xfce4 \
    tigervnc-standalone-server \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 创建必要的目录
RUN mkdir -p /opt/novnc/utils/websockify && \
    mkdir -p /etc/supervisor/conf.d

# 下载 noVNC 并解压
RUN wget https://github.com/novnc/noVNC/archive/v1.2.0.tar.gz -O /tmp/noVNC.tar.gz && \
    tar -xzf /tmp/noVNC.tar.gz -C /opt/novnc --strip-components=1 && \
    rm /tmp/noVNC.tar.gz

# 下载 websockify 并解压
RUN wget https://github.com/novnc/websockify/archive/v0.10.0.tar.gz -O /tmp/websockify.tar.gz && \
    tar -xzf /tmp/websockify.tar.gz -C /opt/novnc/utils/websockify --strip-components=1 && \
    rm /tmp/websockify.tar.gz

# 配置 supervisor
COPY supervisor.conf /etc/supervisor/supervisor.conf

# 配置启动脚本
COPY start.sh /start.sh
RUN chmod +x /start.sh

ADD easy-novnc /easy-novnc
RUN chmod +x /easy-novnc

RUN mkdir -p /root/.vnc && \
    echo "123456" | vncpasswd -f > /root/.vnc/passwd 

ADD xstart.sh /root/.vnc/xstart
RUN chmod +x /root/.vnc/xstart
ENV DISPLAY=:0

# 暴露 noVNC 的端口
EXPOSE 8080
EXPOSE 5900

# 启动 supervisor 服务
# CMD ["/usr/bin/supervisorctl", "-c", "/etc/supervisor/supervisor.conf", "start", "all"]
CMD ["/start.sh"]
# CMD ["sh","-c","/easy-novnc --no-url-password"]