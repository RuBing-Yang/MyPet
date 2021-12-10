<%--
  Created by IntelliJ IDEA.
  User: 16096
  Date: 2021/9/26
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DBS.Database" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.math.BigInteger" %>
<%! static Boolean submit = false;%>
<%! static String PHONE_NUMBER = "";%>
<%! static String USERNAME = "";%>
<%! static int USER_ID = -1;%>
<%! static int POST_PERSON_ID = -1;%>
<%! static String user_name = "";%>
<%! static String phone_number = "";%>
<%! static String gender = "";%>
<%! static String address = "";%>
<%! static String birthday = "";%>
<%! static String petnames = "";%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>个人主页</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="home.css" rel="stylesheet">
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
    String post_person_id = request.getParameter("POST_PERSON_ID");
    if (post_person_id != null) {
        POST_PERSON_ID = Integer.parseInt(post_person_id);
        String sql = "SELECT * FROM user WHERE user_id=" + POST_PERSON_ID + ";";
        System.out.println(sql);
        ResultSet rs = Database.retrieveDb(sql);
        if (rs != null && rs.next()) {
            user_name = rs.getString("user_name");
            phone_number = rs.getString("phone_number");
            gender = rs.getString("gender");
            if (gender == null || gender.equals("")) gender = "";
            else if (gender.equals("f")) gender = "女";
            else if (gender.equals("m")) gender = "男";
            address = rs.getString("address");
            birthday = rs.getString("birthday");
        }
        sql = "SELECT pet_name FROM pet, adopt_present WHERE pet.pet_id = adopt_present.pet_id AND adopt_present.user_id=" + USER_ID + ";";
        System.out.println(sql);
        rs = Database.retrieveDb(sql);
        petnames = "";
        if (rs != null) {
            while (rs.next()) {
                System.out.println("petname: " + rs.getString("pet_name"));
                if (rs.getString("pet_name").equals("")) continue;
                if (petnames == null || petnames.equals("")) {
                    petnames = rs.getString("pet_name");
                } else {
                    petnames += ", " + rs.getString("pet_name");
                }
            }
        }
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
                                    <% if (PHONE_NUMBER==null || PHONE_NUMBER.equals("")) { %>
                                    <li class="active"><a href="login.jsp">登录</a></li>
                                    <% } else { %>
                                    <li class="dropdown active">
                                        <a href=<%= "home.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>
                                                   class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                            用户信息<span class="caret"></span>
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
                <div class="page-header">
                    <h1>个人信息</h1>
                </div>
                <div class="row">
                    <div class="col-sm-4">
                        <div class="panel panel-default">
                            <div class="panel-heading">
                                <h3 class="panel-title">昵称</h3>
                            </div>
                            <div class="panel-body" style="color:#000;">
                                <%= user_name%>
                            </div>
                        </div>
                        <div class="panel panel-primary">
                            <div class="panel-heading">
                                <h3 class="panel-title">电话号码</h3>
                            </div>
                            <div class="panel-body" style="color:#000;">
                                <%= phone_number%>
                            </div>
                        </div>
                    </div><!-- /.col-sm-4 -->
                    <div class="col-sm-4">
                        <div class="panel panel-success">
                            <div class="panel-heading">
                                <h3 class="panel-title">性别</h3>
                            </div>
                            <div class="panel-body" style="color:#000;">
                                <%= (gender==null||gender.equals("")) ? "--" : gender%>
                            </div>
                        </div>
                        <div class="panel panel-info">
                            <div class="panel-heading">
                                <h3 class="panel-title">家庭住址</h3>
                            </div>
                            <div class="panel-body" style="color:#000;">
                                <%= (address==null||address.equals("")) ? "--" : address%>
                            </div>
                        </div>
                    </div><!-- /.col-sm-4 -->
                    <div class="col-sm-4">
                        <div class="panel panel-warning">
                            <div class="panel-heading">
                                <h3 class="panel-title">生日</h3>
                            </div>
                            <div class="panel-body" style="color:#000;">
                                <%= (birthday==null||birthday.equals("")) ? "--" : birthday%>
                            </div>
                        </div>
                        <div class="panel panel-danger">
                            <div class="panel-heading">
                                <h3 class="panel-title">宠物</h3>
                            </div>
                            <div class="panel-body" style="color:#000;">
                                <%= (petnames==null||petnames.equals("")) ? "--" : petnames%>
                            </div>
                        </div>
                    </div><!-- /.col-sm-4 -->
                </div>
                <br>
                <button class="btn btn-default btn-lg btn-primary">
                    <a href="#">
                        <font color="black">关注</font>
                    </a>
                </button>

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