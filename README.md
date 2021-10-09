[TOC]

### 云数据库

文思勇需要[登录新的子账号](https://cloud.tencent.com/login/subAccount/100014197550?type=subAccount)，选择**子账号登录**

主账号ID：100014197550

子用户名：WenSiyong

密码：

Q1w2e3r4_

云数据库登录：[点击](https://dms.cloud.tencent.com/#/login)，类型TDSQL-C for MySQL，地域北京，账号`test`，密码`q1w2e3r4_`

### IDEA环境配置问题

打开IDEA（我是2020专业版）先New一个普通Java项目，再配置服务器参数

详细过程见博客[Idea2020.2.3 创建JavaWeb项目(部署Tomcat)方法](https://www.cnblogs.com/rain-alone/p/14015193.html)

将connector的jar包复制到项目中，右键`add as library`

注意：

①IDEA的Tomcat需要把mysql-connector-java-8.0.16.jar放在`web/WEB_INF/lib`中，否则就会出现`Class.forName`错误

②jsp中import的java class不能是直接在root directory下的，需要在src下面再建立包

③如果IDEA配置的端口和服务器相同，注意要先关闭服务器，否则就会出现端口被占用的情况`Address localhost:8080/1099 is already in use`

运行Tomcat9w.exe点击Stop按钮：<img src="https://i.loli.net/2021/09/26/ltq31rFaInXgBcE.png" alt="image-20210926223956880" style="zoom:50%;" />

​	[通用的暴力解决端口占用问题方法](https://blog.csdn.net/qq_41428711/article/details/85008961)

④其他服务器问题：

​	[server log窗口乱码](https://blog.csdn.net/slow_sparrow/article/details/109813868)

​	[每次修改都要重启Tomcat的解决方案](https://blog.csdn.net/weixin_44763595/article/details/113041788)（注意关闭服务器是点击两次红色正方形，退出IDEA一定要关闭服务器！！！）

### Java Web

教材：[jsp 相关文章](https://segmentfault.com/blog/java_3y?search=jsp)，[菜鸟教程](https://www.runoob.com/jsp/jsp-tutorial.html)，[Bootstrap中文文档](https://v3.bootcss.com/components/#btn-groups)

