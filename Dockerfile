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


## 使用 Anaconda 作为基础镜像
#FROM continuumio/anaconda3:latest
#
## 设置工作目录
#ARG WORKING_DIR=/app
#WORKDIR ${WORKING_DIR}
#
## 复制 conda 环境
#COPY ./gldp /opt/conda/envs/gldp
#
## 初始化 conda (可选，但建议保留)
#RUN conda init bash
#
## 将当前目录下的所有文件复制到工作目录 (除了 .dockerignore 中排除的)
#COPY . ${WORKING_DIR}
#
## 设置环境变量，确保 conda 可用
#ENV PATH /opt/conda/bin:$PATH
#
## 暴露端口 (如果你的应用需要)
#EXPOSE 10742
#
## 运行启动命令
#CMD ["conda", "run", "-n", "gldp", "python", "manage.py", "runserver", "0.0.0.0:10742"]
