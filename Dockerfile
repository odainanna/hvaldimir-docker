FROM tensorflow/tensorflow:latest-gpu-jupyter

ENV DEBIAN_FRONTEND=noninteractive

# User configuration - override with --build-arg
ARG user=myuser
ARG group=mygroup
ARG uid=1000
ARG gid=1000

RUN groupadd -g $gid $user
RUN useradd --create-home -u $uid -g $gid $user

RUN apt-get update && apt-get install -y \
    nano \
    sshfs \
    sudo \
    tree \
    wget \
#    python3-opencv \
#    python3-pil \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip

RUN python3 -m pip install --trusted-host pypi.python.org \
    ipywidgets \
    jupyterlab \
    jupyterlab_widgets 
#    matplotlib \
#    numpy \
#    pandas \
#    seaborn \
    
#ENV PATH="/home/$user/.local/bin:${PATH}"

WORKDIR /home/$user

## START OF JUPYTER EXTENSIONS SETUP (skip if you don't need extensions for a faster build)
# Install node and npm in order to use jupyter lab extensions
#RUN curl -fsSL https://deb.nodesource.com/setup_15.x | sudo -E bash -
#RUN apt-get update && apt-get install -y nodejs
# Install a dark theme switch
#RUN jupyter labextension install jupyterlab-topbar-extension jupyterlab-theme-toggle
## END OF JUPYTER EXTENSIONS SETUP 

# Use only GPU 0
ENV CUDA_VISIBLE_DEVICES 0

# Run when the container launches
CMD "bash"
