
# minieap for OpenWRT

这是修改后适用郑州大学校园网的路由器认证客户端，没有luci界面，命令行使用。
命令： 
minieap -u 账号 -p 密码 -n eth0.2 --module printer --module rjv3  --fake-dns2 dns地址 -a 1 -b 3 -d 3 --module printer --if-impl sockraw --service default

## Build

First download [OpenWRT SDK](https://downloads.openwrt.org/) for your device.

```sh
cd /path/to/your/sdk
cd package
git clone https://github.com/2512500960/zzu-minieap-openwrt.git
cd ..
make menuconfig # choose `minieap` in section `Network`
make package/zzu-minieap/compile V=s


```
##Command

以下选项中，[]表示可选参数，<>表示必选参数。

        --help, -h      显示本帮助
        --kill, -k [1]  终止其他实例并退出。加任意非 0 参数表示终止其他实例后继续进行认证
        --save, -w      保存本次认证所用参数
        --username, -u <...>    用户名
        --password, -p <...>    密码
        --nic, -n <...>         要使用的网络界面名
        --stage-timeout, -t <num>       单个认证阶段的超时时间 [默认5]
        --wait-after-fail, -r <num>     认证失败后重新认证前的等待时间（但当服务器要求重新认证时将直接开始认证）[默认30]
        --max-fail, -l <num>    最大允许认证失败次数 [默认3]
        --no-auto-reauth, -x    认证掉线后不允许自动重连 [默认1]
        --daemonize, -b <0-3>   后台运行方式： [默认0]
                                0 = 不后台
                                1 = 后台运行，关闭输出
                                2 = 后台运行，输出到当前控制台
                                3 = 后台运行，输出到日志文件
        --proxy-lan-iface, -z <...>     代理认证时的 LAN 网络界面名 [默认无]
        --auth-round, -j <num>  需要认证的次数 [默认1]
        --max-retries <num>     最大超时重试的次数 [默认3]
        --pid-file <...>        PID 文件路径，设为none可禁用 [默认/var/run/minieap.pid]
        --conf-file <...>       配置文件路径 [默认/etc/minieap.conf]
        --if-impl <...>         选择此网络操作模块，仅允许选择一次 [默认为第一个可用的模块]
        --pkt-plugin <...>      启用此名称的数据包修改器，可启用多次、多个 [默认无]
        --module <...>          同上
                                当命令行选项中存在 --module 或 --pkt-plugin 时，配置文件中的所有 module= 行都将被忽略

以下是可用的网络操作模块：

    sockraw (采用RAW Socket进行通信的轻量网络接口模块)

以下是可用的数据包修改插件及其选项：

    插件名称： printer (将流经此插件的数据包内容打印出来)
        此插件无选项可用

    插件名称： rjv3 (来自 hyrathb@GitHub 的 Ruijie V3 验证算法)
        --heartbeat, -e <num>           心跳间隔秒数 [默认60]
        --eap-bcast-addr, -a <0-1>      Start 包广播地址： [默认BROADCAST_STANDARD]
                                        0 = 标准地址
                                        1 = 锐捷私有地址
        --dhcp-type, -d <0-3>           DHCP 方式： [默认DHCP_AFTER_AUTH]
                                        0 = 不使用 DHCP
                                        1 = 二次认证
                                        2 = 认证前 DHCP
                                        3 = 认证后 DHCP
        --dhcp-script, -c <...>         二次认证之间及认证完成后运行此命令 [默认无]
        --rj-option <type>:<value>[:r]  自定义认证字段，其中 type 和 value 必须为十六进制串
                                        如 --rj-option 6a:000102 表示新增一条类型为 0x6a、内容为 0x00 0x01 0x02的字段
                                        :r 表示替换内置生成的字段，如 --rj-option 6f:000102:r 表示将内置算法生成的类型为 0x6f 的字段内容替换为 0x00 0x12 0x02
                                        当命令行与配置文件中同时存在此选项时，两处的选项都将发挥作用。若认证失败，请检查配置文件中是否有错误的参数
        --service <str>                 自定义服务名 [默认internet]
        --version-str <str>             自定义版本字符串 [默认RG-SU For Linux V1.30]
        --fake-dns1 <str>               自定义主 DNS 地址（点分十进制 IPv4 格式） [默认自动获取]
        --fake-dns2 <str>               自定义次 DNS 地址（IPv4 / IPv6 不限） [默认自动获取]
        --fake-serial <str>             自定义硬盘序列号 [默认自动获取]
        --max-dhcp-count <num>          二次认证时等待 DHCP 结果的允许超时次数 [默认3]
        从 --service 到 --fake-serial（除 --fake-dns1）都是对应的 --rj-option 的简单形式，可直接使用 ASCII 字符串作为参数，不需转化为十六进制表示

注意：选项与参数之间必须用空格分开！
