FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
RUN apt-get update &&\
apt-get install --assume-yes apt-utils &&\
apt-get install -y zsh &&\
apt-get install -y wget &&\
apt-get install -y curl &&\
apt-get install -y libicu55 &&\
apt-get install -y libuv1 &&\
apt-get install -y build-essential &&\
apt-get install -y git &&\
apt-get install -y openssh-server &&\
apt-get install -y vim

RUN mkdir /node
RUN wget -P /node https://nodejs.org/dist/v8.13.0/node-v8.13.0-linux-x64.tar.xz
RUN tar -xvf /node/node-v8.13.0-linux-x64.tar.xz -C /node
RUN ln -s /node/node-v8.13.0-linux-x64/bin/node /usr/local/bin/node
RUN ln -s /node/node-v8.13.0-linux-x64/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm
RUN npm install cnpm -g --registry=https://registry.npm.taobao.org
RUN ln -s /node/node-v8.13.0-linux-x64/bin/cnpm /usr/local/bin/cnpm
RUN cnpm install nrm -g
RUN ln -s /node/node-v8.13.0-linux-x64/bin/nrm /usr/local/bin/nrm
RUN nrm add xnpm http://xnpm.ximalaya.com/
RUN cnpm install n -g
RUN ln -s /node/node-v8.13.0-linux-x64/bin/n /usr/local/bin/n
RUN cnpm install yarn -g
RUN ln -s /node/node-v8.13.0-linux-x64/bin/yarn /usr/local/bin/yarn
RUN cd /
RUN git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh &&\
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc &&\
chsh -s /bin/zsh
RUN sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/' /root/.zshrc
RUN sed -i '$a plugins=(git incr)' /root/.zshrc
RUN mkdir /root/.oh-my-zsh/plugins/incr
RUN wget -P /root/.oh-my-zsh/plugins/incr http://mimosa-pudica.net/src/incr-0.2.zsh
CMD ["zsh"]
