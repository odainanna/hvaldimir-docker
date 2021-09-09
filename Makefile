# Set a new image name
IMAGENAME = hvaldimir
# Choose which volumes to mount
DISKS = -v $(PWD):/home/$(USERNAME)/project
# Set a port (for serving Jupyter)
PORT = 8850

# No need to change anything below unless you want to
USERID    = $(shell id -u)
GROUPID   = $(shell id -g)
USERNAME  = $(shell whoami)
GPUS      = --gpus=1
SSHFSOPTIONS = --cap-add SYS_ADMIN --device /dev/fuse
NETOPTIONS = --network=host

.PHONY: default lab

.docker: ./Dockerfile
	DOCKER_BUILDKIT=1 docker build $(NETOPTIONS) --build-arg user=$(USERNAME) --build-arg uid=$(USERID) --build-arg gid=$(GROUPID) -t $(USERNAME)-$(IMAGENAME) .

RUNCMD = docker run --name $(USERNAME)-$(IMAGENAME) $(GPUS) --rm $(NETOPTIONS) --user $(USERID):$(GROUPID) $(SSHFSOPTIONS) $(DISKS) -it $(USERNAME)-$(IMAGENAME)
default: .docker
	$(RUNCMD) bash

lab: .docker
	$(RUNCMD) jupyter lab --port $(PORT) --no-browser