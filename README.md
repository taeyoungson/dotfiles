# Personal Dotfile Scripts

Build file for personal terminal configuration.  
You can configure to new server by running the following:

```bash
wget -O - https://raw.githubusercontent.com/taeyoungson/dotfiles/main/Dockerfile > ./Dockerfile
docker build \
--tag {TAG} \
--build-arg UBUNTU_VERSION={UBUNTU_VERSION} \
--build-arg BAZEL_VERSION={BAZEL_VERSION} \
--build-arg GIT_NAME={GIT_NAME} \
--build-arg GIT_EMAIL={GIT_EMAIL} \
.
```