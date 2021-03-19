FROM kuv009-hvaldimir-docker:latest

ENV DEBIAN_FRONTEND=noninteractive

COPY requirements-pip.txt /
COPY requirements-apt.txt /
RUN apt-get update && grep -v ^# /requirements-apt.txt | xargs apt-get install -y
RUN python3 -m pip install --trusted-host pypi.python.org -r /requirements-pip.txt

ARG user=$USER

# Fix Jupuyter permissions issue
RUN mkdir -p /home/$user
RUN chown $user /home/$user
RUN mkdir -p /usr/local/share/jupyter
RUN chown -R $user /usr/local/share/jupyter

# Expose port for Jupyter
EXPOSE 8800