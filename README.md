# 目錄

* * * 

*   [資料科技平台](#technology)
    *   [系統架構圖](#composition)
    *   [使用到的PKGs](#pkg)

*   [部署](#deploy)
    *   [系統與環境安裝](#install)
    *   [使用 dt 程式部署 Hadoop](#dt)
    *   [開啟 Hadoop](#Hadoop)

<h2 id="composition">系統架構圖</h2>

![composition](https://github.com/PapakWaqa/DT/blob/main/docs/pics/DT-Architecture.jpg)

    
<h2 id="pkg">使用到的PKGs</h2>

* hadoop-2.10.1.tar.gz(針對ALPINE的OPENJDK編譯過)
* spark-3.0.2-bin-without-hadoop.tgz
* pig-0.17.0.tar.gz
* ache-hive-2.3.7-bin.tar.gz
* apache-tez-0.9.2-bin.tar.gzap


# 使用說明
<h2 id="install"> 系統與環境安裝 </h2>

### 以下程式皆在 gw 內使用
* 下載DT軟體
> git clone https://github.com/PapakWaqa/DT.git
* 將 DT/web/config/hosts ，對應架構圖設定好IP。
> nano DT/web/config/hosts
```
127.0.0.1 localhost
172.29.0.10 gw
172.29.0.11 wka01
172.29.0.12 wka02
172.29.0.13 wka03
172.29.0.17 ds01
172.29.0.18 mas01
```
***
* 執行0set_gw.sh,設定gw的環境變數;
> ./0set_gw.sh
***
* 執行1ssh_keygen_idcopy.sh,產生 SSH 公私鑰並派送到cluster內的所有電腦。
> ./1ssh_keygen_idcopy.sh
***
<h2 id="dt"> 使用 DT 程式部署 Hadoop </h2>

* 將 dt 的執行權限打開

> sudo chmod +x DT-alpine/bin/dt

* * *

* 查看所有機器的硬體規格、IP、Gateway、Openjdk 版本

> dt sysinfo

```
[wka01]
--------------------------------------------------------
CPU :  Common KVM processor (core:2)
Memory : 2.4G
IP Address : addr:172.29.0.11
Default Gateway : 172.29.0.254

openjdk version "1.8.0_275"
OpenJDK Runtime Environment (IcedTea 3.17.1) (Alpine 8.275.01-r0)
OpenJDK 64-Bit Server VM (build 25.275-b01, mixed mode)

```

* * * 

* 更新套件、安裝 Openjdk8、allows users to present environment options to the ssh daemon

> dt sysprep

```
Loading DT environment...OK
Web Server is already start : 172.29.0.10:8888
[wka01]
Add apk repositories... OK
Update apk repositories... OK
Install openjdk-1.8-jdk... OK
Install Python3... OK
Setting SSH environment... OK

```

* * *

* 安裝 hadoop-2.10.1、pig-0.17.0、hive-2.3.7、tez-0.9.2、spark-3.0.2，複製環境變數文件、hadoop、pig、tez等配置文件

> dt build

```
Loading DT environment...OK
Web Server is already start : 192.168.XXX.XXX:XXXX
download Aapche Hadoop-2.10.1...Please Wait
Hadoop-2.10.1 OK
download Aapche pig-0.17.0...Please Wait
pig-0.17.0 OK
download Aapche hive-2.3.7...Please Wait
hive-2.3.7 OK
download Aapche tez-0.9.2...Please Wait
tez-0.9.2 OK
[wka01]
Hadoop is already exists
Install Pig... OK
Hive is already exists
Tez is already exists
environment copied
hosts copied
core-site.xml copied
hdfs-site.xml copied
mapred-site.xml copied
yarn-site.xml copied
tez-site.xml copied
```

* * * 

<h2 id="Hadoop">開啟 Hadoop</h2> 

* 初始化 hdfs

> formatdfs

`Are you sure ? (YES/NO) YES`

```
wka01 clean
wka02 clean
wka03 clean
formathdfs ok
```

* * *

* 停止 namenode、secondarynamenode、datanode

> stophdfs

```
wka01 stop datanode...OK
wka02 stop datanode...OK
wka03 stop datanode...OK
mas01 stop secondarynamenode...OK
mas01 stop namenode...OK
```

* * * 

* 停止 resourcemanager、nodemanager、historyserver

> stopyarn

```
wka01 stop nodemanager...OK
wka02 stop nodemanager...OK
wka03 stop nodemanager...OK
mas01 stop resourcemanager...OK
mas01 stop historyserver...OK
```

* * * 

* 啟動 namenode、secondarynamenode、datanode

> starthdfs

```
mas01 start namenode...OK
mas01 start secondarynamenode...OK
wka01 start datanode...OK
wka02 start datanode...OK
wka03 start datanode...OK
```

* * *

* 啟動 resourcemanager、nodemanager、historyserver

> startyarn

```
mas01 start resourcemanager...OK
mas01 start historyserver...OK
wka01 start nodemanager...OK
wka02 start nodemanager...OK
wka03 start nodemanager...OK
```

* * *

* 檢查DT功能，執行dtest

> dtest
```
[HDFS]
Live datanodes (3):
Name: 172.29.0.11:50010 (wka01)
Name: 172.29.0.12:50010 (wka02)
Name: 172.29.0.13:50010 (wka03)

[YARN]
Total Nodes:3
         Node-Id	     Node-State	Node-Http-Address	Number-of-Running-Containers
     wka03:43279	        RUNNING	       wka03:8042	                           0
     wka02:46689	        RUNNING	       wka02:8042	                           0
     wka01:37731	        RUNNING	       wka01:8042	                           0

[MapReduce]
Estimated value of Pi is 3.80000000000000000000

[Spark]
	 tracking URL: http://mas01:8088/proxy/application_1618919509694_0004/

```
