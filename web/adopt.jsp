<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %>
<%@ page import="Utils.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Utils.Reply" %>
<%@ page import="java.util.Objects" %>
<%@ page import="Utils.Group" %><%--
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
<%! static ArrayList<Post> postList = new ArrayList<>();%>
<%! static HashMap<Integer, Reply> replyList = new HashMap<>();%>
<%! static ArrayList<Group> groupList = new ArrayList<>();%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>领养宠物</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="adopt_.css" rel="stylesheet">
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
    Cookie myCookie[] = request.getCookies();
    if (myCookie != null) {
        for (int i = 0; i < myCookie.length; i++) {
            if (myCookie[i].getName().equals("user_name")) USERNAME = myCookie[i].getValue();
            if (myCookie[i].getName().equals("phone_number")) PHONE_NUMBER = myCookie[i].getValue();
            if (myCookie[i].getName().equals("user_id") && !myCookie[i].getValue().equals(""))
                USER_ID = Integer.parseInt(myCookie[i].getValue());
        }
    }
    postList.clear();
    String sql = "SELECT * FROM post";
    System.out.println(sql);
    ResultSet rs = Database.retrieveDb(sql);
    if (rs != null) {
        while (rs.next()) {
            postList.add(
                    new Post(
                            rs.getInt("post_id"), rs.getString("post_title"), rs.getString("post_intro"),
                            rs.getString("post_context"), rs.getString("post_date"), rs.getString("post_place"),
                            rs.getInt("post_person_id"), rs.getInt("post_pet_id")
                    )
            );
        }
    }

    groupList.clear();
    sql = "SELECT * FROM pet_group";
    System.out.println(sql);
    rs = Database.retrieveDb(sql);
    if (rs != null) {
        while (rs.next()) {
            groupList.add(
                    new Group(
                            rs.getInt("group_id"), rs.getString("group_name"), rs.getString("group_date"),
                            rs.getString("group_introduction"), rs.getInt("group_leader"), rs.getInt("group_activity")
                    )
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
                    <a class="navbar-brand" href=<%="index.jsp"%>>首页</a>
                </div>
                <div id="navbar" class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                        <li><a href=<%="present.jsp"%>>赠送</a></li>
                        <li class="active"><a href="#">收养</a></li>
                        <li><a href=<%="rescue.jsp"%>>救助</a></li>
                        <li><a href=<%="doctor.jsp"%>>医生</a></li>
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



    <div class="container">

        <div class="blog-header">
            <h1 class="blog-title">所有帖子</h1>
            <div class="lead blog-description">
                <p>请给他们一个新家</p>
            </div>
        </div>


        <div class="row">
            <div class="col-sm-8 blog-main my_content">
                <%
                    if (postList == null || postList.size() == 0) {
                %>
                        <br><br>
                        <p><strong>暂无收养帖子</strong></p>
                        <p><strong>点导航栏-赠送，发个帖子丰富内容吧</strong></p>
                        <br><br><br><br><br><br>
                <%
                    }
                %>

                <%
                    for (int i = postList.size() - 1; i >= 0; i--) {
                        sql = "SELECT pet_state FROM adopt_present " +
                                "WHERE user_id = " + postList.get(i).getPostPersonId() + " AND pet_id = " + postList.get(i).getPostPetId();
                        System.out.println(sql);
                        rs = Database.retrieveDb(sql);
                        String stateLabel = "初始状态";
                        if (rs != null && rs.next()) {
                            String state = rs.getString("pet_state");
                            stateLabel = Objects.equals(state, "pre") ? "待领养" : (Objects.equals(state, "left") ? "已领养" : "状态出错");
                        }

                        sql = "SELECT user_name FROM user WHERE user_id = " + postList.get(i).getPostPersonId();
                        System.out.println(sql);
                        String publisherName = "游客";
                        rs = Database.retrieveDb(sql);
                        if (rs != null && rs.next()) {
                            publisherName = rs.getString("user_name");
                        }
                %>
                    <div class="row">
                        <div class="jumbotron">
                            <div class = "my_box">
                                <p><%= stateLabel%></p>
                                <h2><%= postList.get(i).getPostTitle()%></h2>
                                <p><%= postList.get(i).getPostIntro()%></p>
                                <p class="blog-post-meta"><%= postList.get(i).getPostDate()%> by
                                    <a href=<%= "intro.jsp?"
                                            + "POST_PERSON_ID=" + postList.get(i).getPostPersonId()%>>
                                        <%=publisherName%> </a>    <%= postList.get(i).getPostPlace()%></p>
                            </div>
                            <p><a class="btn btn-lg btn-primary opacity-75" href=<%="postDetail.jsp?POST_ID=" + postList.get(i).getPostId()%> role="button">查看详情</a></p>
                            <hr>
                        </div>
                    </div><!-- /.row -->
                <%
                    }
                %>
            </div><!-- /.blog-main -->



            <div class="col-md-2" role="complementary"> </div>
            <div class="col-md-3 my_sidebar" role="complementary">
                <div class="row">
                    <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">

                        <div class="sidebar-module">
                            <h3>小组</h3>
                            <%
                                if (USER_ID == -1) {
                            %>
                            <p>登录后可创建小组</p>
                            <%
                                } else {
                            %>
                            <p><a class="btn btn-lg btn-primary" href=<%="createGroup.jsp"%> role="button">创建小组</a></p>
                            <%
                                }
                            %>
                        </div>

                        <div class="sidebar-module sidebar-module-inset">
                            <p>进入小组，获取更多内容</p>
                            <%
                                for (int i = 0; i < groupList.size(); i++) {
                                    //第i个小组
                            %>

                            <p><a href=<%="group.jsp?GROUP_ID=" + groupList.get(i).getGroupId()%>><%= groupList.get(i).getGroupName() %>
                            </a></p>

                            <% } %>
                        </div>

                    </nav>
                </div><!-- /.row -->
            </div>


        </div><!-- /.row -->

    </div><!-- /.container -->


</div>


<!-- Carousel
================================================== -->
<%--<div id="myCarousel" class="carousel slide" data-ride="carousel">--%>
<%--    <!-- Indicators -->--%>
<%--    <ol class="carousel-indicators">--%>
<%--        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>--%>
<%--        <li data-target="#myCarousel" data-slide-to="1"></li>--%>
<%--        <li data-target="#myCarousel" data-slide-to="2"></li>--%>
<%--    </ol>--%>
<%--    <div class="carousel-inner" role="listbox">--%>
<%--        <div class="item active">--%>
<%--            <img class="first-slide" src="img/slide1.png" alt="First slide">--%>
<%--            <div class="container">--%>
<%--                <div class="carousel-caption">--%>
<%--                    <h1>领养代替购买</h1>--%>
<%--                    <p>"领养代替购买，让爱不再流浪。"</p>--%>
<%--                    <!--<p><a class="btn btn-lg btn-primary" href="login.jsp" role="button">Sign up today</a></p>-->--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="item">--%>
<%--            <img class="second-slide" src="img/slide2.png" alt="Second slide">--%>
<%--            <div class="container">--%>
<%--                <div class="carousel-caption">--%>
<%--                    <h1>每个生命都是美好的</h1>--%>
<%--                    <p>"给生命以爱，给宠物以家。"</p>--%>
<%--                    <!--<p><a class="btn btn-lg btn-primary" href="login.jsp" role="button">Learn more</a></p>-->--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="item">--%>
<%--            <img class="third-slide" src="img/slide3.png" alt="Third slide">--%>
<%--            <div class="container">--%>
<%--                <div class="carousel-caption">--%>
<%--                    <h1>为它我能做些什么</h1>--%>
<%--                    <p>"陪伴是最长情的告白，对所有生命都是。"</p>--%>
<%--                    <!--<p><a class="btn btn-lg btn-primary" href="login.jsp" role="button">Browse gallery</a></p>-->--%>
<%--                </div>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--    <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">--%>
<%--        <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>--%>
<%--        <span class="sr-only">Previous</span>--%>
<%--    </a>--%>
<%--    <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">--%>
<%--        <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>--%>
<%--        <span class="sr-only">Next</span>--%>
<%--    </a>--%>
<%--</div><!-- /.carousel -->--%>






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
