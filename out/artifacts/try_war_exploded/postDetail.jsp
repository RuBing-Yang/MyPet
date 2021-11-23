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
<%! static int POST_ID = -1;%>
<%! static Post post;%>
<%! static ArrayList<Reply> replyList = new ArrayList<>();%>
<%! static String REPLY_CONTEXT = "";%>
<%! static boolean isPublisher = false;%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>帖子详情</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="adopt.css" rel="stylesheet">
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
    String post_id = request.getParameter("POST_ID");
    if (phoneNumber != null) {
        int userId = Integer.parseInt(request.getParameter("USER_ID"));
        PHONE_NUMBER = phoneNumber;
        USERNAME = username;
        USER_ID = userId;
        POST_ID = Integer.parseInt(post_id);
    }

    String sql;
    ResultSet rs;

    sql = "SELECT * FROM post WHERE post_id =" + POST_ID;
    System.out.println(sql);
    rs = Database.retrieveDb(sql);
    if (rs != null && rs.next()) {
        post = new Post(
                        rs.getInt("post_id"), rs.getString("post_title"), rs.getString("post_intro"),
                        rs.getString("post_context"), rs.getString("post_time"), rs.getString("post_place"),
                        rs.getInt("post_likes_number"), rs.getInt("post_person_id"), rs.getInt("post_pet_id")
                );
    }

    String reply_context = request.getParameter("reply_context");
    if (reply_context != null) {
        reply_context = new String((request.getParameter("reply_context")).getBytes("ISO-8859-1"),"UTF-8");
        REPLY_CONTEXT = reply_context;
        System.out.println(USER_ID + "  " + POST_ID + "  " + REPLY_CONTEXT);
        sql = "INSERT INTO reply (reply_person_id, reply_context) VALUES ("
                + USER_ID + ",'" + REPLY_CONTEXT + "');";
        System.out.println(sql);
        Database.createDb(sql);

        sql = "SELECT reply_id FROM reply WHERE reply_context = '" + REPLY_CONTEXT + "' AND reply_person_id = " + USER_ID + ";";
        System.out.println(sql);
        rs = Database.retrieveDb(sql);
        int reply_id = -1;
        if (rs != null && rs.next()) {
            reply_id = rs.getInt("reply_id");
        }

        sql = "INSERT INTO reply_post (post_id, reply_id) VALUES ("
                + POST_ID + "," + reply_id + ");";
        System.out.println(sql);
        Database.createDb(sql);

        sql = "SELECT * FROM adopt_present WHERE user_id = " + USER_ID + " AND pet_id = " + post.getPostPetId() + ";";
        System.out.println(sql);
        rs = Database.retrieveDb(sql);
        if (rs != null && rs.next()) {
            
        } else {
            sql = "INSERT INTO adopt_present (user_id, pet_id, pet_state) VALUES ("
                    + USER_ID + "," + post.getPostPetId() + ", 'need');";
            System.out.println(sql);
            Database.createDb(sql);
        }
    }

    isPublisher = post.getPostPersonId() == USER_ID;
    System.out.println(post.getPostPersonId() + " " + USER_ID);

    sql = "SELECT * FROM reply, reply_post WHERE reply.reply_id = reply_post.reply_id AND reply_post.post_id = " + POST_ID;
    System.out.println(sql);
    rs = Database.retrieveDb(sql);
    replyList.clear();
    if (rs != null) {
        while (rs.next()) {
            System.out.println(rs.getString("reply_context"));
            replyList.add(new Reply(rs.getInt("reply_id"), rs.getString("reply_context"),
                    rs.getInt("reply_likes_number"), rs.getInt("reply_person_id")));
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
                        <li class="active"><a href="#">收养</a></li>
                        <li><a href=<%="rescue.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>救助</a></li>

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

    </div>


</div>


<!-- Carousel
================================================== -->
<div id="myCarousel" class="carousel slide" data-ride="carousel">
    <!-- Indicators -->
    <ol class="carousel-indicators">
        <li data-target="#myCarousel" data-slide-to="0" class="active"></li>
        <li data-target="#myCarousel" data-slide-to="1"></li>
        <li data-target="#myCarousel" data-slide-to="2"></li>
    </ol>
    <div class="carousel-inner" role="listbox">
        <div class="item active">
            <img class="first-slide" src="img/slide1.png" alt="First slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Example headline.</h1>
                    <p>Note: If you're viewing this page via a <code>file://</code> URL, the "next" and "previous" Glyphicon buttons on the left and right might not load/display properly due to web browser security rules.</p>
                    <p><a class="btn btn-lg btn-primary" href="login.jsp" role="button">Sign up today</a></p>
                </div>
            </div>
        </div>
        <div class="item">
            <img class="second-slide" src="img/slide2.png" alt="Second slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>Another example headline.</h1>
                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                    <p><a class="btn btn-lg btn-primary" href="login.jsp" role="button">Learn more</a></p>
                </div>
            </div>
        </div>
        <div class="item">
            <img class="third-slide" src="img/slide3.png" alt="Third slide">
            <div class="container">
                <div class="carousel-caption">
                    <h1>One more for good measure.</h1>
                    <p>Cras justo odio, dapibus ac facilisis in, egestas eget quam. Donec id elit non mi porta gravida at eget metus. Nullam id dolor id nibh ultricies vehicula ut id elit.</p>
                    <p><a class="btn btn-lg btn-primary" href="login.jsp" role="button">Browse gallery</a></p>
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


<div class="container">

    <div class="blog-header">
        <h1 class="blog-title">递爱宠物屋</h1>
        <p class="lead blog-description">领养代替购买，让爱不再流浪</p>
    </div>

    <div class="row">

        <div class="col-sm-8 blog-main">

            <div class="blog-post">
                <h2 class="blog-post-title"><%= post.getPostTitle()%></h2>
                <%
                    sql = "SELECT user_name FROM user WHERE user_id = " + post.getPostPersonId();
                    System.out.println(sql);
                    String publisherName = "游客";
                    rs = Database.retrieveDb(sql);
                    if (rs != null && rs.next()) {
                        publisherName = rs.getString("user_name");
                    }
                %>
                <p class="blog-post-meta">January 1, 2014 by <a href="#"><%=publisherName%></a></p>

                <p><%= post.getPostIntro()%></p>
                <hr>
                <blockquote>
                    <p> <strong> <%= post.getPostContext()%> </strong></p>
                </blockquote>
                <p>in <%= post.getPostPlace()%></p>
                <h2>回复</h2>

                <div class="inner cover">
                    <form class="form-signin" action="postDetail.jsp" method="POST" role="form" data-toggle="validator" novalidate>
                        <h3>我要回复</h3>
                        <div class="form-group has-feedback">
                            <label for="inputReplyContext" class="sr-only">回复内容</label>
                            <textarea type="text" id="inputReplyContext" class="form-control" placeholder="内容"
                                      name="reply_context" rows="3" required autofocus></textarea>
                        </div>
                        <div class="form-group">
                            <button class="btn btn-lg btn-primary btn-block" type="submit">添加回复</button>
                        </div>
                    </form>

                </div>

                <h3>所有回复</h3>
                <%
                    if (replyList.isEmpty()) {
                %>
                    <div class="sidebar-module sidebar-module-inset">
                        <h4>暂无回复</h4>
                    </div>
                <%
                    } else {
                        for (int i = 0; i < replyList.size(); i++) {
                            sql = "SELECT user_name FROM user WHERE user_id = " + replyList.get(i).getReplyPersonId();
                            System.out.println(sql);
                            String userName = "游客";
                            rs = Database.retrieveDb(sql);
                            if (rs != null && rs.next()) {
                                userName = rs.getString("user_name");
                            }
                %>
                            <p class="blog-post-meta">January 1, 2014 by <a href="#"><%= userName%></a></p>
                            <div class="sidebar-module sidebar-module-inset">
                                <h4><%= replyList.get(i).getReplyContext()%></h4>
                            </div>
                <%
                            if (isPublisher && replyList.get(i).getReplyPersonId() != post.getPostPersonId()) {

                %>
                                <p><a class="btn btn-default" href="#" role="button">赠送</a></p>
                <%
                            }
                %>
                <%
                        }
                    }
                %>
            </div><!-- /.blog-post -->

        </div><!-- /.blog-main -->

    </div><!-- /.row -->

</div><!-- /.container -->

<footer class="blog-footer">
    <p>Blog template built for <a href="https://getbootstrap.com/">Bootstrap</a> by <a href="https://twitter.com/mdo">@mdo</a>.</p>
    <p>
        <a href="#">Back to top</a>
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
