FROM fedora:latest

RUN dnf update -y && dnf install -y bash arch-install-scripts bubblewrap systemd-container zip python3-pip dosfstools e2fsprogs rsync which 

# TODO: remove this when mkosi-15 will be in the repos
RUN dnf install -y git

RUN python3 -m pip install --user git+https://github.com/systemd/mkosi.git@v15.1

# Install qemu-user-static for other architectures
RUN uname -m | grep aarch64 || dnf install -y qemu-user-static-aarch64

WORKDIR /build/

COPY . .

CMD ["/bin/sh", "./docker-entry.sh"]
