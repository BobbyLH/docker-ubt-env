FROM ubuntu:16.04
ENV DEBIAN_FRONTEND noninteractive
ENV BUILD_ESSENTIALS="zsh wget curl libicu55 libuv1 build-essential libtool libpcre3 libpcre3-dev libssl-dev zlib1g-dev zip unzip daemon git openssh-server openssl vim expect sysvinit-utils systemd nginx gcc g++ cmake"

# install ubuntu basic package
RUN apt-get update &&\
apt-get install --assume-yes apt-utils &&\
apt-get install -y $BUILD_ESSENTIALS &&\
# install node relative package
mkdir /node &&\ 
wget -P /node https://nodejs.org/dist/v8.16.0/node-v8.16.0-linux-x64.tar.xz &&\
tar -xvf /node/node-v8.16.0-linux-x64.tar.xz -C /node &&\
ln -s /node/node-v8.16.0-linux-x64/bin/node /usr/local/bin/node &&\
ln -s /node/node-v8.16.0-linux-x64/lib/node_modules/npm/bin/npm-cli.js /usr/local/bin/npm &&\
npm install cnpm -g --registry=https://registry.npm.taobao.org &&\
ln -s /node/node-v8.16.0-linux-x64/bin/cnpm /usr/local/bin/cnpm &&\
cnpm install nrm -g &&\
ln -s /node/node-v8.16.0-linux-x64/bin/nrm /usr/local/bin/nrm &&\
nrm add hnpm http://hnpm.ximalaya.com/ &&\
cnpm install n -g &&\
ln -s /node/node-v8.16.0-linux-x64/bin/n /usr/local/bin/n &&\
cnpm install yarn -g &&\
ln -s /node/node-v8.16.0-linux-x64/bin/yarn /usr/local/bin/yarn &&\
cnpm install pm2 -g &&\
ln -s /node/node-v8.16.0-linux-x64/bin/pm2 /usr/local/bin/pm2 &&\
cd / &&\
git clone https://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh &&\
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc &&\
chsh -s /bin/zsh &&\
sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="ys"/' /root/.zshrc &&\
sed -i '$a plugins=(git incr)' /root/.zshrc &&\
mkdir /root/.oh-my-zsh/plugins/incr &&\
wget -P /root/.oh-my-zsh/plugins/incr http://mimosa-pudica.net/src/incr-0.2.zsh &&\
mkdir /v2ray && cd /v2ray && wget https://install.direct/go.sh &&\
zsh /v2ray/go.sh &&\
# deploy ssh server
echo 'root:screencast' | chpasswd &&\
sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config &&\
sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd &&\
echo "export VISIBLE=now" >> /etc/profile

ENV NOTVISIBLE "in users profile"
EXPOSE 22

CMD ["zsh"]
