FROM tensorflow/tensorflow:latest-gpu-jupyter

ENV DEBIAN_FRONTEND=noninteractive

# User configuration - override with --build-arg
ARG user=myuser
ARG group=mygroup
ARG uid=1000
ARG gid=1000

# Add user and group
RUN groupadd -g $gid $user
RUN useradd --create-home -u $uid -g $gid $user

# Install packages with apt
RUN apt-get update && apt-get install -y \
    nano \
    tree \
    && rm -rf /var/lib/apt/lists/*

# Install packages with pip
RUN pip install --upgrade pip
RUN pip install --trusted-host pypi.python.org \
    ipywidgets \
    jupyterlab \
    jupyterlab_widgets 

# Set working directory to home 
WORKDIR /home/$user

# Use only GPU 0
ENV CUDA_VISIBLE_DEVICES 0

# Run when the container launches
CMD "bash"
