<%@ page import="Utils.Product" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %><%--
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
<%! static ArrayList<Product> productList = new ArrayList<>();%>
<%! String hint = "";%>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>宠物用品</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="product.css" rel="stylesheet">
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

    PHONE_NUMBER = "";
    USERNAME = "";
    USER_ID = -1;
    hint = request.getParameter("hint");
    Cookie myCookie[] = request.getCookies();
    if (myCookie != null) {
        for (int i = 0; i < myCookie.length; i++) {
            if (myCookie[i].getName().equals("user_name")) USERNAME = myCookie[i].getValue();
            if (myCookie[i].getName().equals("phone_number")) PHONE_NUMBER = myCookie[i].getValue();
            if (myCookie[i].getName().equals("user_id") && !myCookie[i].getValue().equals(""))
                USER_ID = Integer.parseInt(myCookie[i].getValue());
        }
    }

    String sql = "SELECT * FROM product";
    ResultSet rs = Database.retrieveDb(sql);
    productList.clear();
    if (rs != null) {
        while (rs.next()) {
            productList.add(new Product(rs.getInt("product_id"), rs.getInt("product_type"), rs.getString("product_name"), rs.getNString("product_photo"),
                    rs.getString("product_introduction"), rs.getDouble("product_price"), rs.getString("product_link")));
        }
    }

    for (Product product : productList) {
        System.out.println(product);
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
                        <li><a href=<%="doctor.jsp"%>>医生</a></li>
                        <li class="active"><a href="#">商品</a></li>
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
                                <li><a onclick="return confirmDel()" href="index.jsp?operation=delete">注销账号</a></li>
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
            if (productList.size()==0) {
        %>
        <div class="alert alert-danger" role="alert">
            <strong>暂无商品信息</strong>
        </div>
        <% } %>
        <%
                for (int i = 0; i < productList.size(); i = i + 3) {
        %>
        <div class="row">
            <h1><%= productList.get(i).getProductType() == 1 ? "狗狗用品" : productList.get(i).getProductType() == 2 ? "猫咪用品" : "其他用品"%></h1>
            <div class="col-lg-4">
                <div class="my_box_">
                    <img class="img-circle" src="<%= productList.get(i).getProductPhoto()%>" alt="Generic placeholder image" width="140" height="140">
                    <h2><%= productList.get(i).getProductName()%></h2>
                    <p><%= productList.get(i).getProductIntroduction()%></p>
                </div>

                <%
                    if (USER_ID != -1) {
                %>
                <p><a class="btn btn-lg btn-primary" href=<%= "productDetail.jsp?PRODUCT_ID=" + (i+1)%>
                        role="button">查看详情 &raquo;
                </a></p>
                <%
                } else {
                %>
                <p><a class="btn btn-lg btn-primary" href=<%= "product.jsp?hint=请先登录"%> role="button">查看详情 &raquo;
                </a></p>
                <%
                    }
                %>
            </div><!-- /.col-lg-4 -->
            <div class="col-lg-4">
                <div class="my_box_">
                    <img class="img-circle" src="<%= productList.get(i+1).getProductPhoto()%>" alt="Generic placeholder image" width="140" height="140">
                    <h2><%= productList.get(i+1).getProductName()%></h2>
                    <p><%= productList.get(i+1).getProductIntroduction()%></p>
                </div>
                <%
                    if (USER_ID != -1) {
                %>
                <p><a class="btn btn-lg btn-primary" href=<%= "productDetail.jsp?PRODUCT_ID=" + (i+2)%>
                        role="button">查看详情 &raquo;
                </a></p>
                <%
                } else {
                %>
                <p><a class="btn btn-lg btn-primary" href=<%= "product.jsp?hint=请先登录"%> role="button">查看详情 &raquo;
                </a></p>
                <%
                    }
                %>
            </div><!-- /.col-lg-4 -->
            <div class="col-lg-4">
                <div class="my_box_">
                    <img class="img-circle" src="<%= productList.get(i+2).getProductPhoto()%>" alt="Generic placeholder image" width="140" height="140">
                    <h2><%= productList.get(i+2).getProductName()%></h2>
                    <p><%= productList.get(i+2).getProductIntroduction()%></p>
                </div>
                <%
                    if (USER_ID != -1) {
                %>
                <p><a class="btn btn-lg btn-primary" href=<%= "productDetail.jsp?PRODUCT_ID=" + (i+3)%>
                        role="button">查看详情 &raquo;
                </a></p>
                <%
                } else {
                %>
                <p><a class="btn btn-lg btn-primary" href=<%= "product.jsp?hint=请先登录"%> role="button">查看详情 &raquo;
                </a></p>
                <%
                    }
                %>
            </div><!-- /.col-lg-4 -->
        </div><!-- /.row -->
        <%
                }
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
