# Set these variables
IMAGENAME = hvaldimir-docker
COMMAND   = bash
DISKS     = -v /data/deep/data:/data:ro -v $(PWD):/project
USERID    = $(shell id -u)
GROUPID   = $(shell id -g)
USERNAME  = $(shell whoami)
GPUS      = --gpus=1

# No need to change anything below this line

.PHONY: .docker default

SSHFSOPTIONS = --cap-add SYS_ADMIN --device /dev/fuse

NETOPTIONS = --network=host
.docker: docker/Dockerfile docker/requirements-apt.txt docker/requirements-pip.txt
	docker build $(NETOPTIONS) --build-arg user=$(USERNAME) --build-arg uid=$(USERID) --build-arg gid=$(GROUPID) -t $(USERNAME)-$(IMAGENAME) docker

RUNCMD=docker run $(GPUS) --rm $(NETOPTIONS) --user $(USERID):$(GROUPID) $(SSHFSOPTIONS) $(DISKS) -it $(USERNAME)-$(IMAGENAME)

default: .docker
	$(RUNCMD) $(COMMAND)


