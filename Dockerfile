# 使用 Anaconda 官方镜像作为基础镜像，指定 Python 版本
FROM continuumio/anaconda3

# 设置 shell
SHELL ["/bin/bash", "-c"]

# 设置工作目录
WORKDIR /app

# 将项目代码复制到容器中
COPY . /app/

# 创建 Anaconda 环境
RUN conda create -n myenv python=3.11

# 安装项目依赖 (从 requirements.txt 文件)
RUN conda run -n myenv pip install djangorestframework

# 暴露端口 (Django 默认端口是 8000)
EXPOSE 8000

CMD ["conda", "run", "-n", "myenv", "python", "manage.py", "runserver", "0.0.0.0:8000"]
