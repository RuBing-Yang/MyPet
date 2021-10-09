<%--
  Created by IntelliJ IDEA.
  User: 16096
  Date: 2021/9/26
  Time: 21:29
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>注册/登录</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="login.css" rel="stylesheet">
    <!-- Just for debugging purposes. Don't actually copy these 2 lines! -->
    <!--[if lt IE 9]><script src="bootstrap-3.4.1/docs/assets/js/ie8-responsive-file-warning.js"></script><![endif]-->
    <script src="bootstrap-3.4.1/docs/assets/js/ie-emulation-modes-warning.js"></script>
    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!--[if lt IE 9]>
    <script src="https://oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
    <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
    <![endif]-->
</head>
<body>

    <div class="site-wrapper">

        <div class="site-wrapper-inner">

            <div class="cover-container">

                <div class="masthead clearfix">
                    <div class="inner">
                        <h3 class="masthead-brand">递爱宠物屋</h3>
                        <nav>
                            <ul class="nav masthead-nav">
                                <li><a href="index.jsp">首页</a></li>
                                <li><a href="present.jsp">赠送</a></li>
                                <li><a href="adopt.jsp">收养</a></li>
                                <li><a href="rescue.jsp">救助</a></li>
                                <li class="active"><a href="#">登录</a></li>
                            </ul>
                        </nav>
                    </div>
                </div>

                <div class="inner cover">
                    <form class="form-signin">
                        <h2 class="form-signin-heading">请先登录</h2>
                        <label for="inputUsername" class="sr-only">用户名</label>
                        <input type="email" id="inputUsername" class="form-control" placeholder="用户名" required autofocus>
                        <label for="inputPassword" class="sr-only">密码</label>
                        <input type="password" id="inputPassword" class="form-control" placeholder="密码" required>
                        <div class="checkbox">
                            <label>
                                <input type="checkbox" value="remember-me"> 遵守网站规则
                            </label>
                        </div>
                        </br>
                        <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
                        </br>
                        <button class="btn btn-default btn-lg btn-primary btn-block" onclick="window.location='register.jsp'">注册</button>
                    </form>
                </div>

            </div>

        </div>

    </div>

    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="bootstrap-3.4.1/docs/assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="bootstrap-3.4.1/docs/dist/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="bootstrap-3.4.1/docs/assets/js/ie10-viewport-bug-workaround.js"></script>

</body>
</html>
