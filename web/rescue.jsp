<%@ page import="java.util.ArrayList" %>
<%@ page import="Utils.Pet" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %><%--
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
<%! static ArrayList<Pet> rescuePetsList = new ArrayList<>();%>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>救助流浪动物</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="rescue.css" rel="stylesheet">
    <link href="rescue2.css" rel="stylesheet">


    <link rel="canonical" href="https://yarn.bootcss.com/">
    <link rel="alternate" type="application/rss+xml" title="Yarn 中文文档" href="https://yarn.bootcss.com/feed.xml">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/fontawesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="rescue2.css">



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

    String sql = "SELECT * FROM pet WHERE rescue = 1";
    System.out.println(sql);
    ResultSet rs = Database.retrieveDb(sql);
    rescuePetsList.clear();
    if (rs != null) {
        while (rs.next()) {
            rescuePetsList.add(new Pet(rs.getInt("pet_id"), rs.getInt("pet_variety"), rs.getString("pet_name"),
                    rs.getInt("pet_age"), rs.getString("pet_gender"), rs.getString("pet_remarks"), rs.getInt("rescue")));
        }
    }
    for (Pet pet : rescuePetsList) {
        sql = "SELECT * FROM adopt_present WHERE pet_id = " + pet.getPetId();
        System.out.println(sql);
        rs = Database.retrieveDb(sql);
        if (rs.next()) {
            int user_id = rs.getInt("user_id");
            sql = "SELECT * FROM user WHERE user_id = " + user_id;
            String user_name = "";
            System.out.println(sql);
            rs = Database.retrieveDb(sql);
            if (rs.next()) user_name = rs.getString("user_name");
            pet.setOwner(user_id, user_name);
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
                    <a class="navbar-brand" href=<%="index.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>首页</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href=<%="present.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>赠送</a></li>
                        <li><a href=<%="adopt.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>收养</a></li>
                        <li class="active"><a href="#">救助</a></li>
                        <li><a href=<%="doctor.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>医生</a></li>
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

    </div><%--<div class="container">--%>

</div>


<div class="container">
    <div class="row row1">
        <div class="col-md-1"></div>
        <div class="col-md-10 col2">

            <br><br><br><br>><br><br>
            <div class="row">
                <div class="col-md-1"></div>
                <div class="col-md-10">

                    <div id="myCarousel" class="carousel slide" data-ride="carousel">
                        <div class="carousel-inner" role="listbox">
                            <div class="item active">
                                <img class="first-slide" src="img/slide1.png" alt="First slide">
                                <div class="container">
                                    <div class="carousel-caption">
                                        <h1>领养代替购买</h1>
                                    </div>
                                </div>
                            </div>
                            <div class="item">
                                <img class="second-slide" src="img/slide2.png" alt="Second slide">
                                <div class="container">
                                    <div class="carousel-caption">
                                        <h1>让爱不再流浪</h1>
                                    </div>
                                </div>
                            </div>
                            <div class="item">
                                <img class="third-slide" src="img/slide3.png" alt="Third slide">
                                <div class="container">
                                    <div class="carousel-caption">
                                        <h1>给它们一个新家</h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                            <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                            <span class="sr-only">Previous</span>
                        </a>
                        <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                            <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                            <span class="sr-only">Next</span>
                        </a>
                    </div><!-- /.carousel -->
                </div>
                <div class="col-md-1"></div>
            </div>

            <%
                for (int i = 0; i < rescuePetsList.size(); i++) {
            %>
            <%
                if (i % 2 == 0) {
            %>
            <div class="row feature">
                <div class="col-lg-7">
                    <h2 class="feature-heading">
                        <%= rescuePetsList.get(i).getPetName()%>
                    </h2>
                    <p class="feature-text">
                        <%= rescuePetsList.get(i).getPetRemarks()%>
                    </p>
                    <p><a class="btn btn-lg btn-primary" href=<%= "petDetail.jsp?PHONE_NUMBER=" + PHONE_NUMBER
                                + "&USERNAME=" + USERNAME
                                + "&USER_ID=" + USER_ID
                                + "&PET_ID=" + rescuePetsList.get(i).getPetId()%>
                            role="button">参考详情 &raquo;
                    </a></p>
                </div>
                <div class="col-lg-5">
                    <img class="feature-image img-fluid mx-auto feature-image-speed" src="img/feature-speed.png" width="500" height="300" alt="Watercolour of cat riding a rocketship">
                </div>
            </div>
            <%
            } else {

            %>
            <div class="row feature">
                <div class="col-lg-7 push-lg-8">
                    <h2 class="feature-heading">
                        <%= rescuePetsList.get(i).getPetName()%>
                    </h2>
                    <p class="feature-text">
                        <%= rescuePetsList.get(i).getPetRemarks()%>
                    </p>
                    <p><a class="btn btn-lg btn-primary" href=<%= "petDetail.jsp?PHONE_NUMBER=" + PHONE_NUMBER
                                + "&USERNAME=" + USERNAME
                                + "&USER_ID=" + USER_ID
                                + "&PET_ID=" + rescuePetsList.get(i).getPetId()%>
                            role="button">参考详情 &raquo;
                    </a></p>
                </div>
                <div class="col-lg-5 pull-lg-7">
                    <img class="feature-image img-fluid mx-auto feature-image-secure" src="img/feature-secure.png" width="375" height="300" alt="Watercolour of cat driving a robot suit">
                </div>
            </div>
            <%
                } //end else
            %>
            <hr class="feature-divider">
            <%
                } //end for
            %>

        </div>

        <div class="col-md-1"></div>
    </div>

</div>


<footer class="my_foot">
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
