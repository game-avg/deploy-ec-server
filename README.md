# deploy-ec-server
deploy a ec server

### 必需依赖
- ubuntu 16.10 + / centos 7 +
- systemd
- docker
>内存最好2G+ 硬盘大小10G+。 如果内存1G的可以创建1个2G的交换文件[点击查看](https://cloud.tencent.com/developer/article/1156834)


### 切换到root用户
如果用的不是root用户， 需要切换到root用户
```shell
sudo su root
```
然后输入自己的密码

### 安装docker, 已安装的可以跳过
```shell
curl -sSL https://get.daocloud.io/docker | sh
```


### 1.初始化数据
创建文件夹， 然后进入`cd /mnt/EC_server`目录
```shell
mkdir -p /mnt/EC_server
cd /mnt/EC_server
```
然后运行下面的命令，如果下载或检验文件出错，请重新执行此命令
```shell
docker pull ystyle/deploy-ec-server:latest && \
docker run --rm -ti \
  --name ec-uploadserver-init \
  -v /mnt/EC_server:/work \
  ystyle/deploy-ec-server
```
> 要下载1G的数据， 如果服务器带宽小的话， 要下载很久， 这命令只需成功执行一次就行了，以后启动服务器看下一步

下载完成结果如下， 都ok了说明下载完了
```shell
Download Results:
gid   |stat|avg speed  |path/URI
======+====+===========+=======================================================
d68a59|OK  |       0B/s|/work/storage.7z.003
6f734e|OK  |       0B/s|/work/storage.7z.001
52effb|OK  |       0B/s|/work/storage.7z.004
4d6e3e|OK  |       0B/s|/work/storage.7z.002
aa5889|OK  |       0B/s|/work/SHASUMS256.txt
efcd9b|OK  |       0B/s|/work/storage.7z.005
4eb84d|OK  |       0B/s|/work/storage.7z.006
ca5f6e|OK  |       0B/s|/work/storage.7z.007

Status Legend:
(OK):download completed.
```
接下来是校验`sha256sum`的结果， 都OK的话说明下载成功，如果检验结果为FAILED， 要删掉FAILED的文件重新执行上面的命令

如下面的`storage.7z.005`校验失败， 要删除这文件， 重新执行上边的命令
```shell
storage.7z.001: OK
storage.7z.002: OK
storage.7z.003: OK
storage.7z.004: OK
storage.7z.005: FAILED
storage.7z.006: OK
storage.7z.007: OK
sha256sum: WARNING: 1 computed checksum did NOT match
```
然后是7z的解压过程, 解压完成就可以跳到下一步了， 有`Everything is Ok`说明解压完成了
```shell
7-Zip [64] 16.02 : Copyright (c) 1999-2016 Igor Pavlov : 2016-05-21
p7zip Version 16.02 (locale=C.UTF-8,Utf16=on,HugeFiles=on,64 bits,1 CPU Intel(R) Xeon(R) CPU E5-26xx v4 (406F1),ASM,AES-NI)

Scanning the drive for archives:
1 file, 157286400 bytes (150 MiB)

Extracting archive: storage.7z.001
--         
Path = storage.7z.001
Type = Split
Physical Size = 157286400
Volumes = 7
Total Physical Size = 1015367887
----
Path = storage.7z
Size = 1015367887
--
Path = storage.7z
Type = 7z
Physical Size = 1015367887
Headers Size = 98655
Method = LZMA2:26
Solid = +
Blocks = 2

Everything is Ok                                                            

Folders: 11
Files: 4902
Size:       6273336016
Compressed: 1015367887
```

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
- 下载服务器补丁文件`url.zip`:  `/api/v1/download/url.zip` 可选参数: `?nocache` 可以重新生成补丁，比如换了ip时
- 排行榜界面 `/api/v1/ranking`
- 服务器报告 `/api/v1/manage/report`
- 清除缓存 `/api/v1/manage/clear/cache?token=admin123` 
- 显示所有可用的地址:  `/api/v1/urls`

>比如下载服务器补丁文件： `http://服务器ip:1321/api/v1/download/url.zip`  
>排行界面： 浏览器打开`http://服务器ip:1321/api/v1/ranking` 其它同理 


如果想公开服务器的话，点击[服务器发布](https://github.com/game-avg/deploy-ec-server/issues/1)提交你的服务器地址