# Personal Dotfile Scripts

Build file for personal terminal configuration.  
Check building and deploying containers. 
Note that you do not have to clone this repository, just copy and paste build snippet. 

### Build your image
```bash
# clone remote build script
wget -O - https://raw.githubusercontent.com/taeyoungson/dotfiles/main/Dockerfile > ./Dockerfile

# build image
docker build \
--tag {TAG} \
--build-arg UBUNTU_VERSION={UBUNTU_VERSION} \
--build-arg BAZEL_VERSION={BAZEL_VERSION} \
--build-arg GIT_NAME={GIT_NAME} \
--build-arg GIT_EMAIL={GIT_EMAIL} \
.
```
### Run your container
```bash
docker run -it \
--gpus all \
--net host \
-v {VOLUMES}:{REMOTE_VOLUMES} \
--name {CONTAINER_NAME} \
{IMAGE}:{TAG}
```
