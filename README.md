[TOC]

## 介绍

### 架构

- web服务器：Tomcat
- 开发语言：Java、JSP、Javascript
- 数据库管理系统：MySQL
- 开发IDE：IDEA
- 前端框架：BootStrap
- 数据库访问接口：JDBC
- 云服务：腾讯TDSQL-C云数据库

### 概念模型

1、实体

- U（用户）：编号、电话、用户名、密码、地址、生日、性别、照
片、注册日期
- P（宠物）：编号、种类、名称、年龄、性别、简介、图片、救助
状态
- C（宠物用品）：编号、名称、价格、图片、简介、链接
- D（宠物医生）：编号、姓名、照片、医龄、简介、联系方式
- N（帖子）：编号、时间、地点、内容、简介、发帖用户、宠物
- R（回复）：编号、回复时间、回复者编号、内容
- G（小组）：编号、组名、成立时间、小组简介、组长、活跃度

2、关系

- U-P（领养/赠养）：用户编号、宠物编号、宠物状态
- U-D（咨询）：咨询编号、用户编号、医生编号、咨询内容、方向
- U-C（浏览）：浏览编号、用户编号、宠物用品编号
- U-N（点赞帖子）：用户编号、帖子编号
- U-G（加入）：用户编号、小组编号、加入时间
- N-R（回复帖子）：帖子编号、回复编号

## 环境配置

### 云数据库

[登录新的子账号](https://cloud.tencent.com/login/subAccount/100014197550?type=subAccount)，选择**子账号登录**

主账号ID：100014197550

子用户名：WenSiyong

云数据库登录：[点击](https://dms.cloud.tencent.com/#/login)，类型TDSQL-C for MySQL，地域北京，账号`test`

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

