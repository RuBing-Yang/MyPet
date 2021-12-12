<%--
  Created by IntelliJ IDEA.
  User: 16096
  Date: 2021/9/11
  Time: 21:13
  To change this template use File | Settings | File Templates.
--%>
<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" language="java" pageEncoding="UTF-8"%>
<%@ page import="DBS.Database" %>
<%@ page import="javax.servlet.http.Cookie" %>
<%! String PHONE_NUMBER = "";%>
<%! String USERNAME = "";%>
<%! int USER_ID = -1;%>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>首页</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="index.css" rel="stylesheet">
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
<%--    <h1>Welcome to My Pet Website!</h1><br>--%>
<%--    <button class="btn btn-default" onclick="window.location='login.jsp'">用户登录</button><br>--%>
<%--    <button class="btn btn-default" onclick="window.location='present.jsp'">赠送宠物</button><br>--%>
<%--    <button class="btn btn-default" onclick="window.location='adopt.jsp'">收养宠物</button><br>--%>
<%--    <button class="btn btn-default" onclick="window.location='chatroom.jsp'">聊天室</button><br>--%>
<%--    <button class="btn btn-default" onclick="window.location='rescue.jsp'">救助流浪动物</button><br>--%>
    <%--
      Database.connectDb();
    --%>
  <%
    Database.connectDb();
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
    String operation = request.getParameter("operation");
    if (USER_ID != -1 && operation != null) {
      if (operation.equals("exit") || operation.equals("delete")) { //退出登录
        for (int i = 0; i < myCookie.length; i++) {
          Cookie delete = myCookie[i];
          delete.setMaxAge(0);
          response.addCookie(delete);
        }
        if (operation.equals("delete")) { //删除账号
          String sql = "DELETE FROM user WHERE user_id=" + USER_ID + ";";
          System.out.println(sql);
          Database.deleteDb(sql);
        }
        PHONE_NUMBER = "";
        USERNAME = "";
        USER_ID = -1;
      }
    }
  %>

    <div class="site-wrapper">

      <div class="site-wrapper-inner">

        <div class="cover-container">

          <div class="masthead clearfix">
            <div class="inner">
              <h3 class="masthead-brand">递爱宠物屋</h3>
              <nav>
                <ul class="nav masthead-nav">
                  <li class="active"><a href="#">首页</a></li>
                  <li><a href=<%="present.jsp"%>>赠送</a></li>
                  <li><a href=<%="adopt.jsp"%>>收养</a></li>
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
              </nav>
            </div>
          </div>

          <div class="inner cover">
            <h1 class="cover-heading">领养代替购买</h1>
            <p class="lead">"领养代替购买，让爱不再流浪。"</br>
              若你选择去爱上一只猫或一只狗，请把目光投向它的身后。</br>
              不去光顾这种生意，能为它和世界增添一点美好的希望</p>
            <% if (USER_ID == -1) { %>
              <p class="lead">
                <a href="login.jsp" class="btn btn-lg btn-default">成为用户</a>
              </p>
            <% }%>
          </div>

          <div class="mastfoot">
            <div class="inner">
              <p>by @递爱宠物屋团队</p>
            </div>
          </div>

        </div>

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
</html>
