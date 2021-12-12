<%--
  Created by IntelliJ IDEA.
  User: 16096
  Date: 2021/9/26
  Time: 21:30
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="DBS.Database" %>
<%@ page import="Utils.Pet" %>
<%@ page import="Utils.Person" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.math.BigInteger" %>
<%! static Boolean submit = false;%>
<%! static String PHONE_NUMBER = "";%>
<%! static String USERNAME = "";%>
<%! static int USER_ID = -1;%>
<%! static int PET_ID = -1;%>
<%! static ArrayList<Pet> petsList = new ArrayList<>();%>

<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <!-- The above 3 meta tags *must* come first in the head; any other head content must come *after* these tags -->
    <meta name="description" content="">
    <meta name="author" content="">
    <title>个人主页</title>
    <link rel="icon" href="img/icon.png">
    <!-- Bootstrap core CSS -->
    <link href="bootstrap-3.4.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- IE10 viewport hack for Surface/desktop Windows 8 bug -->
    <link href="bootstrap-3.4.1/docs/assets/css/ie10-viewport-bug-workaround.css" rel="stylesheet">
    <!-- Custom styles for this template -->
    <link href="petDetail.css" rel="stylesheet">
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
    String pet_id_str = request.getParameter("PET_ID");
    PET_ID = -1;
    if (phoneNumber != null) {
        int userId = Integer.parseInt(request.getParameter("USER_ID"));
        PHONE_NUMBER = phoneNumber;
        USERNAME = username;
        USER_ID = userId;
    }
    if (pet_id_str != null && !pet_id_str.equals("")) {
        PET_ID = Integer.parseInt(pet_id_str);
        petsList.clear();
        String sql = "SELECT * FROM pet WHERE pet_id = " + pet_id_str;
        System.out.println(sql);
        ResultSet rs = Database.retrieveDb(sql);
        if (rs.next()) {
            Pet pet = new Pet(rs.getInt("pet_id"), rs.getString("pet_variety"), rs.getString("pet_name"),
                    rs.getInt("pet_age"), rs.getString("pet_gender"), rs.getString("pet_remarks"), rs.getInt("rescue"));
            pet.setOwner(USER_ID, USERNAME);
            petsList.add(pet);
        }
    }
    else if (USER_ID != -1) {
        petsList.clear();
        ArrayList<Integer> petsIdList = new ArrayList<>();
        String sql = "SELECT * FROM adopt_present WHERE user_id = " + USER_ID;
        System.out.println(sql);
        ResultSet rs = Database.retrieveDb(sql);
        if (rs != null) {
            while (rs.next()) {
                petsIdList.add(rs.getInt("pet_id"));
            }
        }
        for (int i : petsIdList) {
            sql = "SELECT * FROM pet WHERE pet_id = " + i;
            System.out.println(sql);
            rs = Database.retrieveDb(sql);
            if (rs.next()) {
                Pet pet = new Pet(rs.getInt("pet_id"), rs.getString("pet_variety"), rs.getString("pet_name"),
                        rs.getInt("pet_age"), rs.getString("pet_gender"), rs.getString("pet_remarks"), rs.getInt("rescue"));
                pet.setOwner(USER_ID, USERNAME);
                petsList.add(pet);
            }
        }
    }
%>

<div class="site-wrapper">
    <div class="site-wrapper-inner">
        <div class="cover-container">

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

                                    <li class="active"><a href="#">宠物信息</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                </div>
            </div>

        </div>

        <br><br>

        <div class="row">

            <%
                if (petsList.size() == 1) {
                    int i = 0;
            %>

                    <div class="col-md-4"></div>
                    <div class="col-md-4">
                        <div class="panel panel-default pet_panel">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row pet_title">
                                            <div class="col-md-4">
                                                <img src="img/icon.png" class="img-circle img-responsive">
                                            </div>
                                            <div class="col-md-4 pet_name">
                                                <p>名字：<%= petsList.get(i).getPetName() %></p>
                                            </div>
                                            <div class="col-md-4">
                                                <p>主人：<%= petsList.get(i).getOwner().getName() %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="panel panel-default info_panel">
                                                <p>简介：<%= petsList.get(i).getPetRemarks() %></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="row pet_content">种类：<%= petsList.get(i).variety2Chinese() %></div>
                                        <div class="row pet_content">年龄：<%= petsList.get(i).getPetAge()==-1 ? "--" : petsList.get(i).getPetAge()%></div>
                                        <div class="row pet_content">性别：<%= petsList.get(i).getPetGender()==""  ? "--" :
                                                (petsList.get(i).getPetGender().equals("m") ? "公" : "母") %></div>
                                        <div class="row pet_content"><%= petsList.get(i).needRescue() ? "需要救助" : "健康" %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4"></div>

            <%
                } else if (petsList.size() == 2) {
                    int i = 0;
            %>

                    <div class="col-md-2"></div>
                    <div class="col-md-4">
                        <div class="panel panel-default pet_panel">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row pet_title">
                                            <div class="col-md-4">
                                                <img src="img/icon.png" class="img-circle img-responsive">
                                            </div>
                                            <div class="col-md-4 pet_name">
                                                <p>名字：<%= petsList.get(i).getPetName() %></p>
                                            </div>
                                            <div class="col-md-4">
                                                <p>主人：<%= petsList.get(i).getOwner().getName() %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="panel panel-default info_panel">
                                                <p>简介：<%= petsList.get(i).getPetRemarks() %></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="row pet_content">种类：<%= petsList.get(i).variety2Chinese() %></div>
                                        <div class="row pet_content">年龄：<%= petsList.get(i).getPetAge()==-1 ? "--" : petsList.get(i).getPetAge()%></div>
                                        <div class="row pet_content">性别：<%= petsList.get(i).getPetGender()==""  ? "--" :
                                                (petsList.get(i).getPetGender().equals("m") ? "公" : "母") %></div>
                                        <div class="row pet_content"><%= petsList.get(i).needRescue() ? "需要救助" : "健康" %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                <%
                    i = 1;
                %>

                    <div class="col-md-4">
                        <div class="panel panel-default pet_panel">
                            <div class="panel-body">
                                <div class="row">
                                    <div class="col-md-8">
                                        <div class="row pet_title">
                                            <div class="col-md-4">
                                                <img src="img/icon.png" class="img-circle img-responsive">
                                            </div>
                                            <div class="col-md-4 pet_name">
                                                <p>名字：<%= petsList.get(i).getPetName() %></p>
                                            </div>
                                            <div class="col-md-4">
                                                <p>主人：<%= petsList.get(i).getOwner().getName() %></p>
                                            </div>
                                        </div>
                                        <div class="row">
                                            <div class="panel panel-default info_panel">
                                                <p>简介：<%= petsList.get(i).getPetRemarks() %></p>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="col-md-4">
                                        <div class="row pet_content">种类：<%= petsList.get(i).variety2Chinese() %></div>
                                        <div class="row pet_content">年龄：<%= petsList.get(i).getPetAge()==-1 ? "--" : petsList.get(i).getPetAge()%></div>
                                        <div class="row pet_content">性别：<%= petsList.get(i).getPetGender()==""  ? "--" :
                                                (petsList.get(i).getPetGender().equals("m") ? "公" : "母") %></div>
                                        <div class="row pet_content"><%= petsList.get(i).needRescue() ? "需要救助" : "健康" %></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-2"></div>

            <%
                } else {
            %>
                <div class="col-md-12">

            <%
                int i = -1;
                for (int n = 0; i < petsList.size(); n++) {
            %>
                        <div class="row">
            <%
                        for (int j = 0; j < 3; j++) {
                            i++;
                            if (i >= petsList.size()) break;
                            System.out.println("第" + i + "个： 第" + n + "行 第" + j + "列");
            %>

                            <div class="col-md-4">
                                <div class="panel panel-default pet_panel">
                                    <div class="panel-body">
                                        <div class="row">
                                            <div class="col-md-8">
                                                <div class="row pet_title">
                                                    <div class="col-md-4">
                                                        <img src="img/icon.png" class="img-circle img-responsive">
                                                    </div>
                                                    <div class="col-md-4 pet_name">
                                                        <p>名字：<%= petsList.get(i).getPetName() %></p>
                                                    </div>
                                                    <div class="col-md-4">
                                                        <p>主人：<%= petsList.get(i).getOwner().getName() %></p>
                                                    </div>
                                                </div>
                                                <div class="row">
                                                    <div class="panel panel-default info_panel">
                                                        <p>简介：<%= petsList.get(i).getPetRemarks() %></p>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-md-4">
                                                <div class="row pet_content">种类：<%= petsList.get(i).variety2Chinese() %></div>
                                                <div class="row pet_content">年龄：<%= petsList.get(i).getPetAge()==-1 ? "--" : petsList.get(i).getPetAge()%></div>
                                                <div class="row pet_content">性别：<%= (petsList.get(i).getPetGender()==null || petsList.get(i).getPetGender().equals(""))  ? "--" :
                                                        (petsList.get(i).getPetGender().equals("m") ? "公" : "母") %></div>
                                                <div class="row pet_content"><%= petsList.get(i).needRescue() ? "需要救助" : "健康" %></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>


                    <% } %> <%-- 列for j:0->2 --%>

                   </div> <%-- class="each row" --%>
                    <br><br>

                <% } %> <%-- 行for n:0->size/3 --%>


                </div> <%-- class="12 cols" --%>

            <% } %> <%-- else --%>


        </div> <%-- row --%>


        <div class="row">
            <%
                if (USER_ID != -1 && PET_ID == -1) {
            %>
                <button class="btn btn-default btn-lg btn-primary">
                    <a href=<%= "addPet.jsp?PHONE_NUMBER=" + PHONE_NUMBER + "&USERNAME=" + USERNAME  + "&USER_ID=" + USER_ID%>>
                        <font color="black">增添宠物信息</font>
                    </a>
                </button>
            <% } %>
        </div>

        <br><br>

    </div>
</div>


</div><!-- /.container -->


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
