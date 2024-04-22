ARG UBUNTU_VERSION
ARG BAZEL_VERSION
ARG GIT_NAME
ARG GIT_EMAIL
FROM ubuntu:${UBUNTU_VERSION}

ENV HOME "/root"
ENV PYTHONBREAKPOINT "ipdb.set_trace"

# manually set by ty.son considering dependencies
ENV NODE_VERSION "20.12.2"
ENV FZF_VERSION "0.43.0"

# set working directory to /root
WORKDIR /root

# install necessary packages
RUN set -x \
    && apt-get -y update \
    && apt-get -y install \
    git \
    wget \
    vim \
    curl \
    zsh \
    ninja-build \
    gettext \
    cmake \
    unzip \
    build-essential \
    tmux \
    exuberant-ctags \
    tree \
    silversearcher-ag

# install node and npm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash \
    && . ${HOME}/.nvm/nvm.sh \
    && nvm install ${NODE_VERSION} \
    && nvm alias default ${NODE_VERSION} \
    && nvm use default

# build neovim from git
RUN git clone https://github.com/neovim/neovim ./neovim \
    && cd neovim \
    && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    && make install \
    && cd ../ \
    && rm -rf neovim

# configure git
RUN git config --file ${HOME}/.gitconfig.secret user.name "${GIT_NAME}" \
    && git config --file ${HOME}/.gitconfig.secret user.email "${GIT_EMAIL}"

# install miniconda
RUN mkdir -p ${HOME}/.miniconda3 \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ${HOME}/.miniconda3/miniconda.sh \
    && bash ${HOME}/.miniconda3/miniconda.sh -b -u -p ${HOME}/.miniconda3 \
    && rm -rf ${HOME}/.miniconda3/miniconda.sh

# install wookayin-dotfiles
RUN git clone --recursive https://github.com/wookayin/dotfiles.git ${HOME}/.dotfiles \
    && cd ${HOME}/.dotfiles  \
    && ${HOME}/.miniconda3/bin/conda run --no-capture-output -n base python install.py

# install awscli
RUN curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf awscliv2.zip ./aws

# install bazel
RUN apt install apt-transport-https curl gnupg -y \
    && curl -fsSL https://bazel.build/bazel-release.pub.gpg | gpg --dearmor >bazel-archive-keyring.gpg \
    && mv bazel-archive-keyring.gpg /usr/share/keyrings \
    && echo "deb [arch=amd64 signed-by=/usr/share/keyrings/bazel-archive-keyring.gpg] https://storage.googleapis.com/bazel-apt stable jdk1.8" | tee /etc/apt/sources.list.d/bazel.list \
    && apt update \
    && apt install bazel-${BAZEL_VERSION}

# install filbrowser
RUN curl -fsSL https://raw.githubusercontent.com/filebrowser/get/master/get.sh | bash

# install junegunn/fzf version 0.43.0 for dependency
RUN rm -rf ${HOME}/.fzf \
    && git clone --depth 1 --branch ${FZF_VERSION} https://github.com/junegunn/fzf.git ${HOME}/.fzf \
    && ${HOME}/.fzf/install

# execute taeyoung-custom shellscript and add some aliases
RUN wget -O - https://raw.githubusercontent.com/taeyoungson/dotfiles/main/add_custom_settings.sh | bash \
    && echo "alias bazel=bazel-{bazel_version}" >> ~/.zshrc.local

ENTRYPOINT /usr/bin/zsh