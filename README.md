# deploy-ec-server
deploy a ec server

### 必需依赖
- ubuntu 16.10 + / centos 7 +
- systemd
- docker 
>内存最好2G+ 硬盘大小10G+


### 切换到root用户
如果用的不是root用户， 需要切换到root用户
```shell
sudo su root
```
然后输入自己的密码

### 1.初始化数据
创建文件夹， 然后进入`cd /mnt/EC_server`目录
```shell
mkdir -p /mnt/EC_server
cd /mnt/EC_server
```
然后运行下面的命令
```shell
docker run --rm \
  --name ec-uploadserver-init \
  -v /mnt/EC_server:/work \
  ystyle/deploy-ec-server
```
> 要下载1G的数据， 如果服务器带宽小的话， 要下载很久， 这命令只需成功执行一次就行了，以后启动服务器看下一步

### 2.运行服务
先进入`cd /mnt/EC_server`目录
```
cd /mnt/EC_server
sh ./run.sh
```

### 3.自动更新
>因为目录服务器代码还不太稳定， 会经常改， 所以要经常更新到最新版本，用下面的脚本可以每天自动更新到最新版本
```shell
cd /mnt/EC_server
sh ./auto-update.sh
```

### 服务器参数
> 需要懂docker 环境变量

环境变量|说明|默认值
:---|:----------|:-----
HTTP_BODY_LIMIT|文件上传大小, "K, M"|"50M"
USERNAME|管理界面的用户名| "admin"
PASSWORD|管理界面的密码| "admin123"
TOKEN|管理界面的二次确认密码| "admin123"

>使用方法: 修改`run.sh`文件, 把上面的环境变量添加进去，或修改原来的

### 服务器连接说明
- 下载服务器补丁文件`url.zip`:  `/api/v1/download/url.zip`
- 排行榜界面 `/api/v1/ranking`
- 服务器报告 `/api/v1/manage/report`
- 显示所有可用的地址:  `/api/v1/urls`

>比如下载服务器补丁文件： `http://服务器ip:1321/api/v1/download/url.zip`  
>排行界面： 浏览器打开`http://服务器ip:1321/api/v1/ranking` 其它同理 