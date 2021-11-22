<%--
  Created by IntelliJ IDEA.
  User: 16096
  Date: 2021/9/26
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DBS.Database" %>
<%@ page import="java.sql.ResultSet" %>
<%! static String PHONE_NUMBER = "";%>
<%! static String USERNAME = "";%>
<%! static int USER_ID = -1;%>
<%! static String hint = "";%>
<%! static boolean suc = false;%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>注册</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="registerResult.css" rel="stylesheet">
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
    String phoneNumber = request.getParameter("phoneNumber");
    String username = request.getParameter("username");
    String password = request.getParameter("password");
    USER_ID = -1;
    System.out.println("phonenumber:" + phoneNumber + ", username:" + username + ", password:" + password);
    System.out.println("has succeed before:" + suc);
    if (Database.connectDb("test", "q1w2e3r4_")) {
        String sql = "SELECT password FROM user WHERE phone_number='" + phoneNumber + "';";
        System.out.println(sql);
        ResultSet rs = Database.retrieveDb(sql);
        if (rs!=null && rs.next() && rs.getString("password")!=null) {
            if (suc && rs.getString("password").equals(password)) {
                suc = true;
                USERNAME = username;
                PHONE_NUMBER = phoneNumber;
                hint = "";
                sql = "SELECT user_id FROM user WHERE phone_number='" + phoneNumber + "';";
                System.out.println(sql);
                rs = Database.retrieveDb(sql);
                if (rs != null && rs.next()) USER_ID = rs.getInt("user_id");
            } else {
                suc = false;
                hint = "手机号已绑定账号，请直接登录!";
                USERNAME = "";
                PHONE_NUMBER = "";
            }
        }
        else {
            sql = "INSERT INTO user (phone_number,user_name,password) VALUES ("
                    + phoneNumber + ",'" + username + "'," + password + ");";
            System.out.println(sql);
            if (Database.createDb(sql)) {
                suc = true;
                USERNAME = username;
                PHONE_NUMBER = phoneNumber;
                hint = "";
                sql = "SELECT user_id FROM user WHERE phone_number='" + phoneNumber + "';";
                System.out.println(sql);
                rs = Database.retrieveDb(sql);
                if (rs != null && rs.next()) USER_ID = rs.getInt("user_id");
            } else {
                suc = false;
                hint = "创建账户失败，请重试!";
                USERNAME = "";
                PHONE_NUMBER = "";
            }
        }
    } else {
        suc = false;
        hint = "连接数据库失败，请重试!";
        USERNAME = "";
        PHONE_NUMBER = "";
    }
%>


<div class="site-wrapper">
    <div class="site-wrapper-inner">
        <div class="cover-container">

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
                                <a class="navbar-brand" href=<%="index.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>首页</a>
                            </div>
                            <div id="navbar" class="navbar-collapse collapse">
                                <ul class="nav navbar-nav">
                                    <li><a href=<%="present.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>赠送</a></li>
                                    <li><a href=<%="adopt.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>收养</a></li>
                                    <li><a href=<%="rescue.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>救助</a></li>
                                    <li><a href=<%="doctor.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>医生</a></li>
                                    <li><a href=<%="product.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>商品</a></li>

                                    <% if (!suc) { %>
                                        <% if (hint.equals("手机号已绑定账号，请直接登录!")) { %>
                                            <li class="active"><a href="login.jsp">直接登录</a></li>
                                        <% } else { %>
                                            <li class="active"><a href="register.jsp">重试注册</a></li>
                                        <% }%>
                                    <% } else { %>
                                    <li class="dropdown active">
                                        <a href=<%= "home.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>
                                                   class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                            <%= USERNAME%>
                                            <span class="caret"></span>
                                        </a>
                                        <ul class="dropdown-menu">
                                            <li><a href=<%= "home.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>个人主页</a></li>
                                            <li role="separator" class="divider"></li>
                                            <li class="dropdown-header">离开</li>
                                            <li><a href="index.jsp?PHONE_NUMBER=&USERNAME=&USER_ID=">退出登录</a></li>
                                            <li><a onclick="return confirmDel()" href=<%= "index.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&delete=true" + "&USER_ID=" + USER_ID%>>注销账号</a></li>
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
            </div>

            <div class="inner cover">
                <% if (suc) { %>
                <div class="alert alert-success" role="alert">
                    <strong><%= USERNAME%></strong> 您好，您已成功注册账号！
                </div>
                <% }  else { %>
                <div class="alert alert-danger" role="alert">
                    <strong>注册账号失败：</strong><%= hint%>
                </div>
                <% } %>
            </div>

        </div>
    </div>
</div>


</div><!-- /.container -->


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
