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
<%@ page import="java.sql.SQLException" %>
<%@ page import="java.util.ArrayList" %>
<%! static String PHONE_NUMBER = "";%>
<%! static String USERNAME = "";%>
<%! static int USER_ID = -1;%>
<%! static Boolean has_submit = false;%>
<%! int postPetId = -1;%>
<%! String postTitle = "";%>
<%! String postContext = "";%>
<%! String postPlace = "";%>
<%! String postIntro = "";%>
<%! static ArrayList<Integer> petIdList = new ArrayList<>();%>
<%! static ArrayList<String> petNameList = new ArrayList<>();%>


<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>赠送宠物</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="present.css" rel="stylesheet">
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
        String sql;
        ResultSet rs;
        sql = "SELECT pet.pet_id, pet_name FROM pet, adopt_present WHERE pet.pet_id = adopt_present.pet_id AND adopt_present.pet_state = 'own' AND adopt_present.user_id=" + USER_ID + ";";
        System.out.println(sql);
        rs = Database.retrieveDb(sql);
        petIdList.clear();
        petNameList.clear();
        if (rs != null) {
            while (rs.next()) {
                System.out.println("petname: " + rs.getString("pet_name"));
                if (rs.getString("pet_name").equals("")) continue;
                petIdList.add(rs.getInt("pet_id"));
                petNameList.add(rs.getString("pet_name"));
            }
        }
    }
    System.out.println(has_submit);
    if (!has_submit && request.getParameter("postTitle")!=null) {
        postTitle = new String((request.getParameter("postTitle")).getBytes("ISO-8859-1"),"UTF-8");
        postContext = new String((request.getParameter("postContext")).getBytes("ISO-8859-1"),"UTF-8");
        postPlace = new String((request.getParameter("postPlace")).getBytes("ISO-8859-1"),"UTF-8");
        postIntro = new String((request.getParameter("postIntro")).getBytes("ISO-8859-1"),"UTF-8");
        String petInfo = new String((request.getParameter("postPetId")).getBytes("ISO-8859-1"),"UTF-8");
        String[] pet_info = petInfo.split(" ");
        System.out.println(postTitle + " " + postContext + " " + postPlace + " " + petInfo);
        String sql = "";
        if (postTitle != null && postContext != null && postPlace != null) {
            if (!postTitle.equals("") && !postContext.equals("") && !postPlace.equals("") && pet_info.length == 2) {
                postPetId = Integer.parseInt(pet_info[1]);

                sql = "UPDATE adopt_present SET pet_state = 'pre' WHERE user_id = " + USER_ID + " AND pet_id = " + postPetId + ";";
                System.out.println(sql);
                Database.updateDb(sql);

                sql = "INSERT INTO post (post_person_id, post_title, post_intro, post_context, post_place, post_pet_id) VALUES ("
                        + USER_ID + ",'" + postTitle + "','" + postIntro + "','" + postContext + "','" + postPlace + "', " + postPetId + ");";
                System.out.println(sql);
                if (Database.createDb(sql)) {
                    has_submit = true;
                } else {
                    has_submit = false;
                }
            }
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
                            <li class="active"><a href="#">赠送</a></li>
                            <li><a href=<%="adopt.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME + "&USER_ID=" + USER_ID%>>收养</a></li>
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

            <%
                if (!has_submit) {
            %>

            <div class="inner cover">
                <form class="form-signin" action="present.jsp" method="POST" role="form" data-toggle="validator" novalidate>
                    <h2>发一个帖子，为您的宠物找一个新家</h2>
                    <div class="form-group has-feedback">
                        <label for="inputPostTitle" class="sr-only">帖子标题</label>
                        <input type="text" id="inputPostTitle" class="form-control" placeholder="标题"
                               name="postTitle" required autofocus>
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                        <div class="help-block with-errors">请填写帖子标题</div>
                    </div>

                    <div class="form-group has-feedback">
                        <label for="inputPostPet" class="sr-only">选择赠送的宠物</label>
                        <select id="inputPostPet" class="form-control" name="postPetId" >
                            <%
                                if (petNameList.isEmpty()) {
                            %>
                                    <option>您还没有宠物</option>
                            <%
                                } else {
                                    for (int i = 0; i < petIdList.size(); i++) {
                            %>
                                    <option><%=petNameList.get(i)%> <%=petIdList.get(i)%></option>
                            <%
                                    }
                                }
                            %>

                        </select>
                        <div class="help-block with-errors">请选择您要赠送的宠物</div>
                    </div>

                    <div class="form-group has-feedback">
                        <label for="inputPostIntro" class="sr-only">帖子简介</label>
                        <input type="text" id="inputPostIntro" class="form-control"
                               placeholder="简介" name="postIntro" required autofocus>
                        <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                        <div class="help-block with-errors">请填写帖子简介</div>
                    </div>
                    <div class="form-group has-feedback">
                        <label for="inputPostContext" class="sr-only">帖子内容</label>
                        <textarea type="text" id="inputPostContext" class="form-control" placeholder="内容"
                                  name="postContext" rows="10" required autofocus></textarea>
                        <div class="help-block with-errors">请填写帖子内容</div>
                    </div>
                    <div class="form-group has-feedback">
                        <label for="inputPostPlace" class="sr-only">发帖地点</label>
                        <input type="text" id="inputPostPlace"  class="form-control" placeholder="地点"
                               name="postPlace" required autofocus>
                        <div class="help-block with-errors">请填写发帖地点</div>
                    </div>
                    <div class="form-group">
                        <button class="btn btn-lg btn-primary btn-block" type="submit">提交帖子</button>
                    </div>
                </form>

            </div>

            <%
            }
            else {
            %>
            <div class="inner cover">
                <h1 class="cover-heading"><%= postTitle%></h1>
                <p class="lead">
                    <%= postContext%>
                </p>
            </div>
            <%
                    // has_submit = false;
                }
            %>

        </div>
    </div>





    <!-- Bootstrap core JavaScript
    ================================================== -->
    <!-- Placed at the end of the document so the pages load faster -->
    <script src="https://code.jquery.com/jquery-1.12.4.min.js" integrity="sha384-nvAa0+6Qg9clwYCGGPpDQLVpLNn0fRaROjHqs13t4Ggj3Ez50XnGQqc/r8MhnRDZ" crossorigin="anonymous"></script>
    <script>window.jQuery || document.write('<script src="bootstrap-3.4.1/docs/assets/js/vendor/jquery.min.js"><\/script>')</script>
    <script src="bootstrap-3.4.1/docs/dist/js/bootstrap.min.js"></script>
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <script src="bootstrap-3.4.1/docs/assets/js/ie10-viewport-bug-workaround.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/1000hz-bootstrap-validator/0.11.5/validator.min.js"></script>
</body>
</html>
