# syntax=docker/dockerfile:1

FROM ubuntu:24.04 AS base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y \
    zsh git curl build-essential procps sudo

FROM base AS brew
RUN useradd -m -s /bin/zsh aw \
    && mkdir -p /home/linuxbrew/.linuxbrew \
    && chown -R aw:aw /home/linuxbrew
USER aw
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
RUN brew install sheldon starship fd fzf jq bat neovim coreutils

FROM base
RUN useradd -m -s /bin/zsh -G sudo aw \
    && echo "aw ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/aw
COPY --from=brew /home/linuxbrew /home/linuxbrew
RUN chown -R aw:aw /home/linuxbrew

USER aw
WORKDIR /home/aw
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

COPY --chown=aw:aw . /home/aw/dotfiles
RUN cd /home/aw/dotfiles && bash install.sh
RUN sheldon lock

ENTRYPOINT ["/bin/zsh", "-l"]
