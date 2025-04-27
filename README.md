# nabu-fedora-builder

Huge thanks to: [fedora-asahi-builder](https://github.com/leifliddy/asahi-fedora-builder)

Builds a minimal Fedora image to run on Xiaomi Mi Pad 5

Read the [Install instructions](install.md)

## Fedora Package Install

```dnf install arch-install-scripts bubblewrap systemd-container zip```

### Building Notes

- ```qemu-user-static``` is also needed if building the image on a ```non-aarch64``` system  
- Until version 15.x is released for Fedora, install mksoi from git:  
  `python3 -m pip install --user git+https://github.com/systemd/mkosi.git@v15.1`

## Run inside a Docker Container

```
docker build -t 'nabu-fedora-builder' . 
docker run --privileged -v "$(pwd)"/images:/build/images -v "/dev:/dev" nabu-fedora-builder
```

### User Notes

1. The root password is **fedora**
