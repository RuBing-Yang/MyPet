<%@ page import="java.sql.ResultSet" %>
<%@ page import="DBS.Database" %>
<%@ page import="Utils.Post" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="Utils.Reply" %>
<%@ page import="java.util.Objects" %><%--
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
<%! static int POST_ID = -1;%>
<%! static Post post;%>
<%! static ArrayList<Reply> replyList = new ArrayList<>();%>
<%! static String REPLY_CONTEXT = "";%>
<%! static boolean isPublisher = false;%>
<%! static boolean has_submit = false;%>
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
    <link href="postDetail.css" rel="stylesheet">
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
    Cookie myCookie[] = request.getCookies();
    if (myCookie != null) {
        for (int i = 0; i < myCookie.length; i++) {
            if (myCookie[i].getName().equals("user_name")) USERNAME = myCookie[i].getValue();
            if (myCookie[i].getName().equals("phone_number")) PHONE_NUMBER = myCookie[i].getValue();
            if (myCookie[i].getName().equals("user_id") && !myCookie[i].getValue().equals(""))
                USER_ID = Integer.parseInt(myCookie[i].getValue());
        }
    }
    String post_id = request.getParameter("POST_ID");
    if (USER_ID != -1) {
        if (post_id != null && !post_id.equals(""))
            POST_ID = Integer.parseInt(post_id);
    }

    String sql;
    ResultSet rs;


    if (!has_submit && request.getParameter("postTitle")!=null) {
        String postTitle = new String((request.getParameter("postTitle")).getBytes("ISO-8859-1"),"UTF-8");
        String postContext = request.getParameter("postContext");
        postContext = postContext==null ? "" : (new String(postContext.replaceAll("\n", "<br>").getBytes("ISO-8859-1"),"UTF-8"));
        String postPlace = new String((request.getParameter("postPlace")).getBytes("ISO-8859-1"),"UTF-8");
        String postIntro = new String((request.getParameter("postIntro")).getBytes("ISO-8859-1"),"UTF-8");
        String petInfo = new String((request.getParameter("postPetId")).getBytes("ISO-8859-1"),"UTF-8");
        String[] pet_info = petInfo.split(" ");
        System.out.println(postTitle + " " + postContext + " " + postPlace + " " + petInfo);
        sql = "";
        if (postTitle != null && postContext != null && postPlace != null) {
            if (!postTitle.equals("") && !postContext.equals("") && !postPlace.equals("") && pet_info.length == 2) {
                int postPetId = Integer.parseInt(pet_info[1]);

                sql = "UPDATE adopt_present SET pet_state = 'pre' WHERE user_id = " + USER_ID + " AND pet_id = " + postPetId + ";";
                System.out.println(sql);
                Database.updateDb(sql);

                sql = "INSERT INTO post (post_person_id, post_title, post_intro, post_context, post_date, post_place, post_pet_id) VALUES ("
                        + USER_ID + ",'" + postTitle + "','" + postIntro + "','" + postContext + "', curdate(), '" + postPlace + "', " + postPetId + ");";
                System.out.println(sql);
                if (Database.createDb(sql)) {
                    POST_ID = Database.getId();
                    has_submit = true;
                }
            }
        }
    }

    sql = "SELECT * FROM post WHERE post_id =" + POST_ID;
    System.out.println(sql);
    rs = Database.retrieveDb(sql);
    if (rs != null && rs.next()) {
        post = new Post(
                        rs.getInt("post_id"), rs.getString("post_title"), rs.getString("post_intro"),
                        rs.getString("post_context"), rs.getString("post_date"), rs.getString("post_place"),
                        rs.getInt("post_person_id"), rs.getInt("post_pet_id")
                );
    }

    String post_like =request.getParameter("POST_LIKE");
    if (Objects.equals(post_like, "1")) {
        sql = "INSERT INTO like_post (user_id, post_id) VALUES ("
                + USER_ID + ",'" + POST_ID + "');";
        System.out.println(sql);
        Database.createDb(sql);
    } else if (Objects.equals(post_like, "2")) {
        sql = "DELETE FROM like_post WHERE user_id = " + USER_ID + " AND post_id = " + POST_ID;
        System.out.println(sql);
        Database.deleteDb(sql);
    }

    String reply_context = request.getParameter("reply_context");
    if (reply_context != null) {
        REPLY_CONTEXT = new String(reply_context.replaceAll("\n", "<br>").getBytes("ISO-8859-1"),"UTF-8");
        System.out.println(USER_ID + "  " + POST_ID + "  " + REPLY_CONTEXT);
        sql = "INSERT INTO reply (reply_person_id, reply_date, reply_context) VALUES ("
                + USER_ID + ", curdate(), '" + REPLY_CONTEXT + "');";
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
            replyList.add(new Reply(rs.getInt("reply_id"), rs.getString("reply_date"),
                    rs.getString("reply_context"), rs.getInt("reply_person_id")));
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
                        <li><a href=<%="adopt.jsp"%>>收养</a></li>
                        <li class="active"><a href="#">帖子</a></li>
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
            <h1 class="blog-title">递爱宠物屋</h1>
            <div class="lead blog-description">
                <p>领养代替购买，让爱不再流浪</p>
            </div>
        </div>

        <div class="row">

            <div class="col-md-8 blog-main">

                <div class="blog-post my_content">
                    <h2 class="blog-post-title"><%= post.getPostTitle()%></h2>
                    <%
                        sql = "SELECT user_name FROM user WHERE user_id = " + post.getPostPersonId();
                        System.out.println(sql);
                        String publisherName = "游客";
                        rs = Database.retrieveDb(sql);
                        if (rs != null && rs.next()) {
                            publisherName = rs.getString("user_name");
                        }
                        sql = "SELECT * FROM post WHERE post_person_id = " + post.getPostPersonId();
                        System.out.println(sql);
                        ResultSet post_results = Database.retrieveDb(sql);
                        ArrayList<Integer> ids = new ArrayList<>();
                        ArrayList<String> titiles = new ArrayList<>();
                        while (post_results != null && post_results.next()) {
                            ids.add( post_results.getInt("post_id"));
                            titiles.add(post_results.getString("post_title"));
                        }

                        sql = "SELECT * FROM like_post WHERE user_id = " + USER_ID + " AND post_id = " + POST_ID;
                        System.out.println(sql);
                        ResultSet likes = Database.retrieveDb(sql);
                        if (USER_ID != -1 && likes != null && likes.next()) {
                    %>
                    <a href=<%="postDetail.jsp?POST_ID=" + post.getPostId() + "&POST_LIKE=2"%>>取消关注</a></p>
                    <%
                        } else if (USER_ID != -1) {
                    %>
                    <a href=<%="postDetail.jsp?POST_ID=" + post.getPostId() + "&POST_LIKE=1"%>>关注帖子</a></p>
                    <%
                        }
                    %>
                    <p class="blog-post-meta"><%=post.getPostDate()%> <a href=
                            <%="intro.jsp?"+ "POST_PERSON_ID=" + post.getPostPersonId()%>
                    > <%=publisherName%></a></p>
                    <p><%= post.getPostIntro()%></p>
                    <hr>
                    <blockquote>
                        <p> <strong> <%= post.getPostContext()%> </strong></p>
                    </blockquote>
                    <p>in <%= post.getPostPlace()%></p>
                    <h2>回复</h2>

                    <div class="inner cover">
                        <%
                            if (USER_ID == -1) {
                        %>
                        <p>登录后即可回复</p>
                        <%
                            } else {
                        %>
                        <form class="form-signin" action="postDetail.jsp" method="POST" role="form" data-toggle="validator" novalidate>
                            <h3>我要回复</h3>
                            <div class="form-group has-feedback">
                                <label for="inputReplyContext" class="sr-only">回复内容</label>
                                <textarea type="text" id="inputReplyContext" class="form-control" placeholder="内容"
                                          name="reply_context" rows="6" required autofocus></textarea>
                            </div>
                            <div class="form-group">
                                <button class="btn btn-lg btn-primary btn-block" type="submit">添加回复</button>
                            </div>
                        </form>
                        <%
                            }
                        %>

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
                    <p class="blog-post-meta"><%=replyList.get(i).getReplyDate()%> <a href="#"><%= userName%></a></p>
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

            <div class="col-md-1" role="complementary"> </div>
            <div class="col-md-3 my_box" role="complementary">

                <div class="my_sidebar">
                <nav class="bs-docs-sidebar hidden-print hidden-xs hidden-sm affix-top">

                    <div class="sidebar-module sidebar-module-inset">
                        <h2>&emsp;
                            <a href=<%="intro.jsp?POST_PERSON_ID=" + post.getPostPersonId()%>>
                                <%=publisherName%></a>
                        </h2>
<%--                        <p>&emsp; &emsp; 这些年，我见过日升月落，万物以自己的轨迹运行着，也见过野生动物们或壮观或温暖的场景，以及自然环境、野生动物遭到伤害的样子……</p>--%>
<%--                        <p>&emsp; &emsp; 所有有生命的、没有生命的，都是一样重要，共同组成了这个世界。野生动物们和我们人类一样，也是自然的孩子</p>--%>
                    </div>
                    <div class="sidebar-module sidebar-module-inset">
                        <h3>其他文章</h3>
                        <ol class="list-unstyled">
                            <%
                                for (int i = 0; i < ids.size(); i++) {
                            %>
                                <p><a href=<%="postDetail.jsp?POST_ID=" + ids.get(i)%>>
                                    <%= titiles.get(i)%>
                                </a></p>
                            <%
                                }
                            %>
                        </ol>
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
