FROM ubuntu:20.04

# 换源
COPY sources.list /etc/apt/

# 不使用交互式选择，避免部分包等待输入
ENV DEBIAN_FRONTEND noninteractive

# 复制工具
COPY tools /root/

# 更新系统
RUN apt update && apt -y upgrade; \
    apt install -y apt-utils tzdata locales locales-all; \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime; \
    dpkg-reconfigure -f noninteractive tzdata;

# 设置时区
ENV LANG zh_CN.utf8

# 安装基础软件
RUN apt install -y --fix-missing curl wget net-tools inetutils-ping telnet iftop tcpdump unzip; \
    # 安装php
    apt install -y nginx php-fpm; \
    /root/clean;

# 复制基础配置
COPY etc /etc/

# 复制php测试脚本
COPY php /work/

# 启动
CMD /root/start && infinite
