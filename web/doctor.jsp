<%@ page import="java.util.ArrayList" %>
<%@ page import="Utils.Doctor" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %>
<%--
  Created by IntelliJ IDEA.
  User: 16096
  Date: 2021/9/26
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%! String PHONE_NUMBER = "";%>
<%! String USERNAME = "";%>
<%! int USER_ID = -1;%>
<%! static ArrayList<Doctor> doctorList = new ArrayList<>();%>
<%! String hint = "";%>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>宠物医生</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="doctor.css" rel="stylesheet">
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
    hint = request.getParameter("hint");
    PHONE_NUMBER = "";
    USERNAME = "";
    USER_ID = -1;
    Cookie myCookie[] = request.getCookies();
    if (myCookie != null) {
        for (int i = 0; i < myCookie.length; i++) {
            if (myCookie[i].getName().equals("user_name")) USERNAME = myCookie[i].getValue();
            if (myCookie[i].getName().equals("phone_number")) PHONE_NUMBER = myCookie[i].getValue();
            if (myCookie[i].getName().equals("user_id") && !myCookie[i].getValue().equals(""))
                USER_ID = Integer.parseInt(myCookie[i].getValue());
        }
    }

    String sql = "SELECT * FROM doctor";
    ResultSet rs = Database.retrieveDb(sql);
    doctorList.clear();
    if (rs != null) {
        while (rs.next()) {
            doctorList.add(new Doctor(rs.getInt("doctor_id"), rs.getString("doctor_name"), rs.getNString("doctor_photo"),
                    rs.getInt("doctor_work_years"), rs.getString("doctor_introduction"), rs.getString("doctor_contact")));
        }
    }

    for (Doctor doctor : doctorList) {
        System.out.println(doctor);
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
                    <a class="navbar-brand" href=<%="index.jsp"%>>首页</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href=<%="present.jsp"%>>赠送</a></li>
                        <li><a href=<%="adopt.jsp"%>>收养</a></li>
                        <li><a href=<%="rescue.jsp"%>>救助</a></li>
                        <li class="active"><a href="#">医生</a></li>
                        <li><a href=<%="product.jsp"%>>商品</a></li>
                        <% if (USER_ID == -1) { %>
                        <li><a href="login.jsp">登录</a></li>
                        <% } else { %>
                        <li class="dropdown">
                            <a href=<%= "home.jsp"%>
                                       class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">
                                <%= USERNAME%>
                                <span class="caret"></span>
                            </a>
                            <ul class="dropdown-menu">
                                <li><a href=<%= "home.jsp"%>>个人主页</a></li>
                                <li role="separator" class="divider"></li>
                                <li class="dropdown-header">离开</li>
                                <li><a href="index.jsp?operation=exit">退出登录</a></li>
                                <li><a onclick="return confirmDel()" href="index.jsp?operation=delete"> 注销账号</a></li>
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


    <div class="container marketing">
        <%
            if (hint != null && !hint.equals("")) {
        %>
            <div class="alert alert-danger" role="alert">
                <strong>请先登录</strong>
            </div>
        <% } %>

        <%
            if (doctorList.size()==0) {
        %>
            <div class="alert alert-danger" role="alert">
                <strong>暂无医生信息</strong>
            </div>
        <% } %>

        <%
            for (int i = 0; i < doctorList.size(); i = i + 3) {
        %>
            <div class="row">
                <%
                    for (int j = 0; j < 3; j++) {
                %>
                <div class="col-lg-4">
                    <div class="my_box_">
                        <img class="img-circle" src="<%= doctorList.get(i + j).getDoctorPhoto()%>" alt="Generic placeholder image" width="140" height="140">
                        <h2><%= doctorList.get(i + j).getDoctorName()%></h2>
                        <p><%= doctorList.get(i + j).getDoctorIntroduction()%></p>
                    </div>
                    <%
                        if (USER_ID != -1) {
                    %>
                        <p><a class="btn btn-lg btn-primary" href=<%= "doctorDetail.jsp?DOCTOR_ID=" + (i + j + 1)%>
                                role="button">咨询 &raquo;
                        </a></p>
                    <%
                        } else {
                    %>
                        <p><a class="btn btn-lg btn-primary" href=<%= "doctor.jsp?hint=请先登录"%> role="button">咨询 &raquo;
                        </a></p>
                    <%
                        }
                    %>

                </div><!-- /.col-md-4 -->

                <%
                    } // for j
                %>
            </div><!-- /.row -->
        <%
            } // for i
        %>


    </div><!-- /.container -->

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
