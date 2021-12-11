<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %>
<%@ page import="Utils.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Utils.Reply" %>
<%@ page import="Utils.Product" %><%--
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
<%! static int PRODUCT_ID = -1;%>
<%! static Product curProduct = null;%>
<%! static ArrayList<Product> browseList = new ArrayList<>();%>
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
        int productId = Integer.parseInt(request.getParameter("PRODUCT_ID"));
        PHONE_NUMBER = phoneNumber;
        USERNAME = username;
        USER_ID = userId;
        PRODUCT_ID = productId;
    }

    String sql = "SELECT * FROM product WHERE product_id = " + PRODUCT_ID;
    System.out.println(sql);
    ResultSet rs = Database.retrieveDb(sql);
    if (rs != null && rs.next()) {
        curProduct = new Product(rs.getInt("product_id"), rs.getInt("product_type"), rs.getString("product_name"), rs.getNString("product_photo"),
                rs.getString("product_introduction"), rs.getDouble("product_price"), rs.getString("product_link"));
    }

    sql = "SELECT product.* FROM product, browse WHERE browse.user_id = " + USER_ID + " AND browse.product_id = product.product_id";
    System.out.println(sql);
    rs = Database.retrieveDb(sql);
    browseList.clear();
    if (rs != null) {
        while (rs.next()) {
            browseList.add(new Product(rs.getInt("product_id"), rs.getInt("product_type"), rs.getString("product_name"), rs.getNString("product_photo"),
                    rs.getString("product_introduction"), rs.getDouble("product_price"), rs.getString("product_link"))
            );
        }
    }

    sql = "INSERT INTO browse (user_id, product_id) VALUES ("
            + USER_ID + ", " + PRODUCT_ID + ");";
    Database.createDb(sql);
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
                        <li><a href=<%="doctor.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>医生</a></li>
                        <li class="active"><a href="#">商品</a></li>
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
                    <h2 class="blog-post-title"><%= curProduct.getProductName()%></h2>
                    <div class="inner cover">
                        <p><%= curProduct.getProductIntroduction()%></p>
                        <p><%= curProduct.getProductPrice()%></p>
                        <a><%= curProduct.getProductLink()%></a>
                    </div>
                </div><!-- /.blog-post -->

            </div><!-- /.blog-main -->

            <div class="col-md-1" role="complementary"> </div>
            <div class="col-md-3 my_box" role="complementary">

                <div class="my_sidebar">
                    <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">

                        <div class="sidebar-module sidebar-module-inset">
                            <h2>最近浏览</h2>
                            <%
                                for (int i = browseList.size() - 1, j = 0; i >= 0 && j < 6; i--, j++) {
                            %>

                            <p><a href=<%="productDetail.jsp?PHONE_NUMBER=" + PHONE_NUMBER
                                    + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID
                                    + "&PRODUCT_ID=" + browseList.get(i).getProductId()%>><%= browseList.get(i).getProductName() %>
                            </a></p>

                            <% } %>
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
