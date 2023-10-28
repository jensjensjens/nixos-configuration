FROM ubuntu:latest AS core

SHELL ["/bin/bash", "-c", "-o", "pipefail"]

ENV TZ=Europe/Stockholm
ENV DEBIAN_FRONTEND=noninteractive

RUN useradd --create-home --shell /bin/bash jens.sigvardsson && \
    usermod -aG sudo jens.sigvardsson && \
    mkdir -m 0755 /nix && \
    chown jens.sigvardsson /nix

RUN apt-get update && apt-get install -y \
    curl \
    xz-utils \
    git \
    && rm -rf /var/lib/apt/lists/*

USER jens.sigvardsson
ENV USER=jens.sigvardsson
ENV NIX_PATH=${NIX_PATH:+$NIX_PATH:}/home/jens.sigvardsson/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels
ENV PATH="${PATH}:/home/jens.sigvardsson/.nix-profile/bin"

WORKDIR /home/jens.sigvardsson

RUN sh <(curl -L https://nixos.org/nix/install) --no-daemon

RUN nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager && \
    nix-channel --update && \
    nix-shell '<home-manager>' -A install

COPY . .config/home-manager

RUN home-manager switch

ENTRYPOINT [ "zsh" ]
