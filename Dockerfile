# syntax=docker/dockerfile:1

FROM ubuntu:24.04 AS base
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
      build-essential ca-certificates curl git procps sudo zsh \
    && rm -rf /var/lib/apt/lists/*

FROM base AS brew
RUN useradd -m -s /bin/zsh aw \
    && mkdir -p /home/linuxbrew/.linuxbrew \
    && chown -R aw:aw /home/linuxbrew
USER aw
RUN NONINTERACTIVE=1 /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"
RUN brew install sheldon starship fd fzf jq bat neovim coreutils uv \
    go node ripgrep tree-sitter-cli

FROM base
RUN useradd -m -s /bin/zsh -G sudo aw \
    && echo "aw ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/aw
COPY --from=brew --chown=aw:aw /home/linuxbrew /home/linuxbrew

USER aw
WORKDIR /home/aw
ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:${PATH}"

COPY --chown=aw:aw . /home/aw/dotfiles
RUN cd /tmp && bash /home/aw/dotfiles/install.sh
RUN sheldon lock

RUN zsh -fc 'source ~/.zprofile; initial=$PATH; unset __ZPROFILE; source ~/.zprofile; [[ $PATH == $initial ]]' \
    && bash --noprofile --norc -c \
      'source ~/.bashrc; initial=$PATH; unset DOTFILES_BASH_PROFILE_LOADED; source ~/.bash_profile; [[ $PATH == "$initial" ]]'
RUN /home/aw/dotfiles/tests/nvim-smoke.sh

ENTRYPOINT ["/bin/zsh", "-l"]
