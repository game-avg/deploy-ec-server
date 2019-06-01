# deploy-ec-server
deploy a ec server

### 必需依赖
- ubuntu 16.10 + / centos 7 +
- systemd
- docker 
- git

### 切换到root用户
如果用的不是root用户， 需要切换到root用户
```shell
sudo su root
```
然后输入自己的密码

### 1.下载代码
执行以下所有命令
```shell
mkdir -p /mnt/EC_server
git clone https://github.com/game-avg/deploy-ec-server.git /mnt/EC_server
cd /mnt/EC_server
chmod +x ./auto-update.sh
chmod +x ./run.sh
```
### 2.初始化数据
先进入`cd /mnt/EC_server`目录
```shell
cd /mnt/EC_server
```
然后运行下面的命令
```shell
docker run --rm \
  --name ec-uploadserver-init \
  -v "$PWD/storage":/app/storage \
  ystyle/deploy-ec-server
```

### 3.运行服务
先进入`cd /mnt/EC_server`目录
```$xslt
cd /mnt/EC_server
```
```
sh run.sh
```

### 4. 自动更新
>因为目录服务器代码还不太稳定， 会经常改， 所以要经常更新到最新版本，用下面的脚本可以更新到最新
先进入`cd /mnt/EC_server`目录
```$xslt
cd /mnt/EC_server
```
```shell
sh auto-update.sh
```