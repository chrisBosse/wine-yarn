FROM thawsystems/wine-stable:latest

USER root

RUN wget -nc https://dl.winehq.org/wine-builds/winehq.key \
  && apt-key add winehq.key \
  && apt-get update -y && apt-get install -y \
  git \
  && rm -rf /var/lib/apt/lists/*

USER wine
WORKDIR $HOME

RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash \
  && export NVM_DIR="$HOME/.nvm" \
  && [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" \
  && [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" \
  && nvm install lts/dubnium \
  && curl -o- -L https://yarnpkg.com/install.sh | bash \
  && export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

COPY ./docker-entrypoint.sh /
ENTRYPOINT [ "/docker-entrypoint.sh" ]
CMD ["bash"]