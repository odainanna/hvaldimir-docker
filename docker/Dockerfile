# Use an official Python runtime as a parent image
# FROM nvidia/cuda:11.2.1-runtime-ubuntu20.04
# FROM tensorflow/tensorflow:latest-gpu-jupyter
FROM pytorch/pytorch:latest

# Set the working directory to 
WORKDIR /project

# Copy what you need into the working directory
COPY requirements-pip.txt /
COPY requirements-apt.txt /

# User configuration - override with --build-arg
ARG user=myuser
ARG group=mygroup
ARG uid=1000
ARG gid=1000

# Install any needed packages specified in requirements-*.txt
RUN apt-get update && grep -v ^# /requirements-apt.txt | xargs apt-get install -y 
RUN python3 -m pip install --trusted-host pypi.python.org -r /requirements-pip.txt

RUN groupadd -g $gid $user
RUN useradd -u $uid -g $gid $user

# Make port X available to the world outside this container
# EXPOSE X

# Define environment variable
# Use only GPU 0
ENV CUDA_VISIBLE_DEVICES 0

# Run when the container launches
CMD "bash"
