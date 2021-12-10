<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %>
<%@ page import="Utils.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Utils.Reply" %><%--
  Created by IntelliJ IDEA.
  User: 16096
  Date: 2021/9/26
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! static String PHONE_NUMBER = "";%>
<%! static String USERNAME = "";%>
<%! static int USER_ID = -1;%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>医生</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="productDetail.css" rel="stylesheet">
    <%--<link href="bootstrap-3.4.1/docs/examples/cover/cover.css" rel="stylesheet">--%>
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

<%
    String phoneNumber = request.getParameter("PHONE_NUMBER");
    String username = request.getParameter("USERNAME");
    if (phoneNumber != null) {
        int userId = Integer.parseInt(request.getParameter("USER_ID"));
        PHONE_NUMBER = phoneNumber;
        USERNAME = username;
        USER_ID = userId;
    }
%>

<div class="navbar-wrapper">
    <div class="container">

        <nav class="navbar navbar-inverse navbar-static-top">
            <div class="container">
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
                        <span class="sr-only">Toggle navigation</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand" href=<%="index.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME%>>首页</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href=<%="present.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>赠送</a></li>
                        <li><a href=<%="adopt.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>收养</a></li>
                        <li><a href=<%="rescue.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>救助</a></li>
                        <li class="active"><a href="#">医生</a></li>
                        <li><a href=<%="product.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>商品</a></li>
                        <% if (PHONE_NUMBER==null || PHONE_NUMBER.equals("")) { %>
                        <li><a href="login.jsp">登录</a></li>
                        <% } else { %>
                        <li class="dropdown">
                            <a href=<%= "home.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>
                                       class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <%= USERNAME%>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href=<%= "home.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>个人主页</a></li>
                                <li role="separator" class="divider"></li>
                                <li class="dropdown-header">离开</li>
                                <li><a href="index.jsp?PHONE_NUMBER=&USERNAME=">退出登录</a></li>
                                <li><a onclick="return confirmDel()" href=<%= "index.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID + "&delete=true"%>>注销账号</a></li>
                                <script type="text/javascript">
                                    function confirmDel()
                                    {
                                        return window.confirm("您确定要注销您的账号吗？\n注销账号后，个人数据无法恢复！");
                                    }
                                </script>
                            </ul>
                        </li>
                        <% } %>
                    </ul>
                </div>
            </div>
        </nav>

    </div>

    <div class="container">

        <div class="blog-header">
            <h1 class="blog-title">购买商品</h1>
            <p class="lead blog-description">领养代替购买，让爱不再流浪</p>
        </div>

        <div class="row">

            <div class="col-md-8 blog-main">

                <div class="blog-post my_content">
                    <h2 class="blog-post-title">商品名</h2>
                    <div class="inner cover">
                        <p>商品介绍</p>
                    </div>
                </div><!-- /.blog-post -->

            </div><!-- /.blog-main -->

            <div class="col-md-1" role="complementary"> </div>
            <div class="col-md-3 my_box" role="complementary">

                <div class="my_sidebar">
                    <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">

                        <div class="sidebar-module sidebar-module-inset">
                            <h2>产品分类</h2>
                            <p>其他产品</p>
                        </div>
                    </nav>
                </div>
            </div>

        </div><!-- /.row -->

    </div><!-- /.container -->


</div>







<footer class="blog-footer">
    <p> </p>
    <p>

    </p>
</footer>

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
