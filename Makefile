# Set a new image name
IMAGENAME = hvaldimir-docker
# Choose which volumes to mount
DISKS = -v $(PWD):/project
# Set a port (for Jupyter)
PORT = 8890
# Set the relative path to the directory with the base Dockerfile
DOCKERPATH = docker

# No need to change anything below unless you want to
USERID    = $(shell id -u)
GROUPID   = $(shell id -g)
USERNAME  = $(shell whoami)
GPUS      = --gpus=1
SSHFSOPTIONS = --cap-add SYS_ADMIN --device /dev/fuse
NETOPTIONS = --network=host

.PHONY: default .build-base .build-jupyter lab

BUILDARGS = --build-arg user=$(USERNAME) --build-arg uid=$(USERID) --build-arg gid=$(GROUPID)
.build-base: $(DOCKERPATH)/Dockerfile $(DOCKERPATH)/requirements-apt.txt $(DOCKERPATH)/requirements-pip.txt
	docker build $(NETOPTIONS) $(BUILDARGS) -t $(USERNAME)-$(IMAGENAME) $(DOCKERPATH)
.build-jupyter: $(DOCKERPATH)-jupyter/Dockerfile $(DOCKERPATH)-jupyter/requirements-apt.txt $(DOCKERPATH)-jupyter/requirements-pip.txt
	docker build $(NETOPTIONS) $(BUILDARGS) -t $(USERNAME)-$(IMAGENAME)-jupyter $(DOCKERPATH)-jupyter

RUNCMD = docker run $(GPUS) --rm $(NETOPTIONS) --user $(USERID):$(GROUPID) $(SSHFSOPTIONS) $(DISKS) -it $(USERNAME)-$(IMAGENAME)
default: .build-base
	$(RUNCMD) bash
lab: .build-base .build-jupyter
	$(RUNCMD)-jupyter jupyter lab --ip '$(hostname -I)' --port $(PORT) --no-browser  --allow-root