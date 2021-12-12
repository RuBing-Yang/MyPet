------------------------------
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %>
<%@ page import="Utils.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Utils.Reply" %>
<%@ page import="Utils.Doctor" %>
<%@ page import="Utils.Consult" %><%--
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
<%! static int DOCTOR_ID = -1;%>
<%! static Doctor curDoctor = null;%>
<%! static ArrayList<Consult> consultList = new ArrayList<>();%>
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
    <link href="doctorDetail.css" rel="stylesheet">
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
        int doctorId = Integer.parseInt(request.getParameter("DOCTOR_ID"));
        PHONE_NUMBER = phoneNumber;
        USERNAME = username;
        USER_ID = userId;
        DOCTOR_ID = doctorId;
    }
    String sql;

    String consult_context = request.getParameter("consult_context");;
    if (consult_context != null) {
        consult_context = new String((request.getParameter("consult_context")).replaceAll("\n", "<br>").getBytes("ISO-8859-1"),"UTF-8");
        System.out.println(consult_context);
        // 加入用户咨询内容
        sql = "INSERT INTO consult (user_id, doctor_id, consult_item, consult_direction) VALUES ("
                + USER_ID + ", " + DOCTOR_ID + ", '" + consult_context + "', 1);";
        System.out.println(sql);
        Database.createDb(sql);
        // 加入自动生成的咨询回复
        sql = "INSERT INTO consult (user_id, doctor_id, consult_item, consult_direction) VALUES ("
                + USER_ID + ", " + DOCTOR_ID + ", '抱歉，我现在有事，请稍后咨询', 0);";
        System.out.println(sql);
        Database.createDb(sql);
    }

    sql = "SELECT * FROM doctor WHERE doctor_id = " + DOCTOR_ID;
    System.out.println(sql);
    ResultSet rs = Database.retrieveDb(sql);
    if (rs != null && rs.next()) {
        curDoctor = new Doctor(rs.getInt("doctor_id"), rs.getString("doctor_name"), rs.getNString("doctor_photo"),
                rs.getInt("doctor_work_years"), rs.getString("doctor_introduction"), rs.getString("doctor_contact"));
    }

    sql = "SELECT * FROM consult WHERE user_id = " + USER_ID + " AND doctor_id = " + DOCTOR_ID;
    System.out.println(sql);
    rs = Database.retrieveDb(sql);
    consultList.clear();
    if (rs != null) {
        while (rs.next()) {
            consultList.add(new Consult(rs.getInt("consult_id"), rs.getString("consult_item"),
                    rs.getInt("user_id"), rs.getInt("doctor_id"), rs.getInt("consult_direction"))
            );
        }
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
            <h1 class="blog-title">咨询医生</h1>
            <p class="lead blog-description">领养代替购买，让爱不再流浪</p>
        </div>

        <div class="row">

            <div class="col-md-8 blog-main">


                <div class="inner cover">
                    <form class="form-signin" action="doctorDetail.jsp" method="POST" role="form" data-toggle="validator" novalidate>
                        <h3>我要咨询</h3>
                        <div class="form-group has-feedback">
                            <label for="inputConsultContext" class="sr-only">咨询内容</label>
                            <textarea type="text" id="inputConsultContext" class="form-control" placeholder="内容"
                                      name="consult_context" rows="3" required autofocus></textarea>
                        </div>
                        <div class="form-group">
                            <button class="btn btn-lg btn-primary btn-block" type="submit">发送</button>
                        </div>
                    </form>

                </div>

                <div class="blog-post my_content">
                    <h2 class="blog-post-title">咨询记录</h2>
                    <div class="inner cover">
                        <%
                            for (int i = consultList.size() - 1; i >= 0; i--) {
                                if (consultList.get(i).getConsultDirection() == 0) {
                        %>
                        <p><%= curDoctor.getDoctorName()%>:<%= consultList.get(i).getConsultItem()%></p>
                        <%      } else {%>
                        <p>我：<%= consultList.get(i).getConsultItem()%></p>
                        <%      }%>
                        <% } %>
                    </div>
                </div><!-- /.blog-post -->

            </div><!-- /.blog-main -->

            <div class="col-md-1" role="complementary"> </div>
            <div class="col-md-3 my_box" role="complementary">

                <div class="my_sidebar">
                    <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">

                        <div class="sidebar-module sidebar-module-inset">
                            <h2><%= curDoctor.getDoctorName() %></h2>
                            <p>简介：<%= curDoctor.getDoctorIntroduction() %></p>
                            <p>工作经历：<%= curDoctor.getDoctorWorkYears() %>年</p>
                            <p>联系方式：<%= curDoctor.getDoctorContact() %></p>
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
