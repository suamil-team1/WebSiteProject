<%@page import="model.projectboard.calendarDTO"%>
<%@page import="java.util.Calendar"%>
<%@page import="model.projectboard.calendarDAO"%>
<%@page import="java.net.URLEncoder"%>
<%@page import="util.BoardPage"%>
<%@page import="model.projectboard.projectboardDAO"%>
<%@page import="model.projectboard.ProjectBoardDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Map"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardName = request.getParameter("boardName");
System.out.println(boardName);
  
//db연결
calendarDAO dao = new calendarDAO(application);
%>
<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <meta name="description" content="">
    <meta name="author" content="">

    <title>인원관리</title>

    <!-- Custom fonts for this template-->
    <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">
    <link
        href="https://fonts.googleapis.com/css?family=Nunito:200,200i,300,300i,400,400i,600,600i,700,700i,800,800i,900,900i"
        rel="stylesheet">

    <!-- Custom styles for this template-->
    <link href="css/sb-admin-2.min.css" rel="stylesheet">

</head>

<body id="page-top">

    <!-- Page Wrapper -->
    <div id="wrapper">

        <!-- Sidebar -->
        <ul class="navbar-nav bg-gradient-primary sidebar sidebar-dark accordion" id="accordionSidebar">

            <!-- Sidebar - Brand -->
            <a class="sidebar-brand d-flex align-items-center justify-content-center" href="index.jsp">
                <div class="sidebar-brand-icon rotate-n-15">
                    <i class="fas fa-laugh-wink"></i>
                </div>
                <div class="sidebar-brand-text mx-3">SB Admin <sup>2</sup></div>
            </a>

            <!-- Divider -->
            <hr class="sidebar-divider my-0">

            <!-- Nav Item - Dashboard -->
            <li class="nav-item">
                <a class="nav-link" href="index.jsp">
                    <i class="fas fa-fw fa-tachometer-alt"></i>
                    <span>Dashboard</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Interface
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapseTwo"
                    aria-expanded="true" aria-controls="collapseTwo">
                    <i class="fas fa-fw fa-cog"></i>
                    <span>게시판관리</span>
                </a>
                <div id="collapseTwo" class="collapse" aria-labelledby="headingTwo" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Custom Components:</h6>
                        <a class="collapse-item" href="board_list03.jsp?boardName=not">공지사항</a>
                        <a class="collapse-item" href="board_list03.jsp?boardName=fre">Buttons</a>
                        <a class="collapse-item" href="board_list03.jsp?boardName=fre">자유게시판</a>
                        <a class="collapse-item" href="board_list03.jsp?boardName=fre">Buttons</a>
                        <a class="collapse-item" href="board_list03.jsp?boardName=ref">정보자료실</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Utilities Collapse Menu -->
            <li class="nav-item active">
                <a class="nav-link" href="#" data-toggle="collapse" data-target="#collapseUtilities"
                    aria-expanded="true" aria-controls="collapseUtilities">
                    <i class="fas fa-fw fa-wrench"></i>
                    <span>Utilities</span>
                </a>
                <div id="collapseUtilities" class="collapse show" aria-labelledby="headingUtilities"
                    data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Custom Utilities:</h6>
                        <a class="collapse-item active" href="utilities-color.jsp">인원관리</a>
                        <a class="collapse-item" href="utilities-border.jsp">Borders</a>
                        <a class="collapse-item" href="utilities-animation.jsp">Animations</a>
                        <a class="collapse-item" href="utilities-other.jsp">Other</a>
                    </div>
                </div>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider">

            <!-- Heading -->
            <div class="sidebar-heading">
                Addons
            </div>

            <!-- Nav Item - Pages Collapse Menu -->
            <li class="nav-item">
                <a class="nav-link collapsed" href="#" data-toggle="collapse" data-target="#collapsePages"
                    aria-expanded="true" aria-controls="collapsePages">
                    <i class="fas fa-fw fa-folder"></i>
                    <span>Pages</span>
                </a>
                <div id="collapsePages" class="collapse" aria-labelledby="headingPages" data-parent="#accordionSidebar">
                    <div class="bg-white py-2 collapse-inner rounded">
                        <h6 class="collapse-header">Login Screens:</h6>
                        <a class="collapse-item" href="login.jsp">Login</a>
                        <a class="collapse-item" href="register.jsp">Register</a>
                        <a class="collapse-item" href="forgot-password.jsp">Forgot Password</a>
                        <div class="collapse-divider"></div>
                        <h6 class="collapse-header">Other Pages:</h6>
                        <a class="collapse-item" href="404.jsp">404 Page</a>
                        <a class="collapse-item" href="blank.jsp">Blank Page</a>
                    </div>
                </div>
            </li>

            <!-- Nav Item - Charts -->
            <li class="nav-item">
                <a class="nav-link" href="charts.jsp">
                    <i class="fas fa-fw fa-chart-area"></i>
                    <span>Charts</span></a>
            </li>

            <!-- Nav Item - Tables -->
            <li class="nav-item">
                <a class="nav-link" href="tables.jsp">
                    <i class="fas fa-fw fa-table"></i>
                    <span>Tables</span></a>
            </li>

            <!-- Divider -->
            <hr class="sidebar-divider d-none d-md-block">

            <!-- Sidebar Toggler (Sidebar) -->
            <div class="text-center d-none d-md-inline">
                <button class="rounded-circle border-0" id="sidebarToggle"></button>
            </div>

        </ul>
        <!-- End of Sidebar -->

        <!-- Content Wrapper -->
        <div id="content-wrapper" class="d-flex flex-column">

            <!-- Main Content -->
            <div id="content">

                <!-- Topbar -->
                <nav class="navbar navbar-expand navbar-light bg-white topbar mb-4 static-top shadow">

                    <!-- Sidebar Toggle (Topbar) -->
                    <button id="sidebarToggleTop" class="btn btn-link d-md-none rounded-circle mr-3">
                        <i class="fa fa-bars"></i>
                    </button>

                    <!-- Topbar Search -->
                    <form
                        class="d-none d-sm-inline-block form-inline mr-auto ml-md-3 my-2 my-md-0 mw-100 navbar-search">
                        <div class="input-group">
                            <input type="text" class="form-control bg-light border-0 small" placeholder="Search for..."
                                aria-label="Search" aria-describedby="basic-addon2">
                            <div class="input-group-append">
                                <button class="btn btn-primary" type="button">
                                    <i class="fas fa-search fa-sm"></i>
                                </button>
                            </div>
                        </div>
                    </form>

                    <!-- Topbar Navbar -->
                    <ul class="navbar-nav ml-auto">

                        <!-- Nav Item - Search Dropdown (Visible Only XS) -->
                        <li class="nav-item dropdown no-arrow d-sm-none">
                            <a class="nav-link dropdown-toggle" href="#" id="searchDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-search fa-fw"></i>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-menu dropdown-menu-right p-3 shadow animated--grow-in"
                                aria-labelledby="searchDropdown">
                                <form class="form-inline mr-auto w-100 navbar-search">
                                    <div class="input-group">
                                        <input type="text" class="form-control bg-light border-0 small"
                                            placeholder="Search for..." aria-label="Search"
                                            aria-describedby="basic-addon2">
                                        <div class="input-group-append">
                                            <button class="btn btn-primary" type="button">
                                                <i class="fas fa-search fa-sm"></i>
                                            </button>
                                        </div>
                                    </div>
                                </form>
                            </div>
                        </li>

                        <!-- Nav Item - Alerts -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="alertsDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-bell fa-fw"></i>
                                <!-- Counter - Alerts -->
                                <span class="badge badge-danger badge-counter">3+</span>
                            </a>
                            <!-- Dropdown - Alerts -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="alertsDropdown">
                                <h6 class="dropdown-header">
                                    Alerts Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-primary">
                                            <i class="fas fa-file-alt text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 12, 2019</div>
                                        <span class="font-weight-bold">A new monthly report is ready to download!</span>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-success">
                                            <i class="fas fa-donate text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 7, 2019</div>
                                        $290.29 has been deposited into your account!
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="mr-3">
                                        <div class="icon-circle bg-warning">
                                            <i class="fas fa-exclamation-triangle text-white"></i>
                                        </div>
                                    </div>
                                    <div>
                                        <div class="small text-gray-500">December 2, 2019</div>
                                        Spending Alert: We've notd unusually high spending for your account.
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Show All Alerts</a>
                            </div>
                        </li>

                        <!-- Nav Item - Messages -->
                        <li class="nav-item dropdown no-arrow mx-1">
                            <a class="nav-link dropdown-toggle" href="#" id="messagesDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <i class="fas fa-envelope fa-fw"></i>
                                <!-- Counter - Messages -->
                                <span class="badge badge-danger badge-counter">7</span>
                            </a>
                            <!-- Dropdown - Messages -->
                            <div class="dropdown-list dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="messagesDropdown">
                                <h6 class="dropdown-header">
                                    Message Center
                                </h6>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_1.svg"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div class="font-weight-bold">
                                        <div class="text-truncate">Hi there! I am wondering if you can help me with a
                                            problem I've been having.</div>
                                        <div class="small text-gray-500">Emily Fowler · 58m</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_2.svg"
                                            alt="...">
                                        <div class="status-indicator"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">I have the photos that you ordered last month, how
                                            would you like them sent to you?</div>
                                        <div class="small text-gray-500">Jae Chun · 1d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="img/undraw_profile_3.svg"
                                            alt="...">
                                        <div class="status-indicator bg-warning"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Last month's report looks great, I am very happy with
                                            the progress so far, keep up the good work!</div>
                                        <div class="small text-gray-500">Morgan Alvarez · 2d</div>
                                    </div>
                                </a>
                                <a class="dropdown-item d-flex align-items-center" href="#">
                                    <div class="dropdown-list-image mr-3">
                                        <img class="rounded-circle" src="https://source.unsplash.com/Mv9hjnEUHR4/60x60"
                                            alt="...">
                                        <div class="status-indicator bg-success"></div>
                                    </div>
                                    <div>
                                        <div class="text-truncate">Am I a good boy? The reason I ask is because someone
                                            told me that people say this to all dogs, even if they aren't good...</div>
                                        <div class="small text-gray-500">Chicken the Dog · 2w</div>
                                    </div>
                                </a>
                                <a class="dropdown-item text-center small text-gray-500" href="#">Read More Messages</a>
                            </div>
                        </li>

                        <div class="topbar-divider d-none d-sm-block"></div>

                        <!-- Nav Item - User Information -->
                        <li class="nav-item dropdown no-arrow">
                            <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button"
                                data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                                <span class="mr-2 d-none d-lg-inline text-gray-600 small"><%=session.getAttribute("UserName") %></span>
                                <img class="img-profile rounded-circle"
                                    src="img/undraw_profile.svg">
                            </a>
                            <!-- Dropdown - User Information -->
                            <div class="dropdown-menu dropdown-menu-right shadow animated--grow-in"
                                aria-labelledby="userDropdown">
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-user fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Profile
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-cogs fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Settings
                                </a>
                                <a class="dropdown-item" href="#">
                                    <i class="fas fa-list fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Activity Log
                                </a>
                                <div class="dropdown-divider"></div>
                                <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logoutModal">
                                    <i class="fas fa-sign-out-alt fa-sm fa-fw mr-2 text-gray-400"></i>
                                    Logout
                                </a>
                            </div>
                        </li>

                    </ul>

                </nav>
                <!-- End of Topbar -->

                <!-- Begin Page Content -->
                <div class="container-fluid">
<!-- Page Heading -->
                    <%			
					if(boardName==null || boardName.equals("not")) {
					%>
                    <h1 class="h3 mb-2 text-gray-800">공지사항 게시판</h1>
                    <p class="mb-4">공지사항을 작성/수정할수있습니다.</p>
                    <%
					}
					else if(boardName.equals("fre")){
					%>
					<h1 class="h3 mb-2 text-gray-800">자유게시판</h1>
                    <p class="mb-4">자유게시판을 작성/수정할수있습니다.</p>
					<%  
					}
					else if(boardName.equals("program")){
					%>
					<h1 class="h3 mb-2 text-gray-800">프로그램일정</h1>
                    <p class="mb-4">프로그램일정을 작성/수정할수있습니다.</p>
					<%   
					}
					else if(boardName.equals("gal")){
					%>
					<h1 class="h3 mb-2 text-gray-800">사진게시판</h1>
                    <p class="mb-4">사진게시판을 작성/수정할수있습니다.</p>
					<% 
					}
					else if(boardName.equals("info")){
					%>
					<h1 class="h3 mb-2 text-gray-800">정보자료실</h1>
                    <p class="mb-4">정보자료실을 작성/수정할수있습니다.</p>
					<%  
					}
					else if(boardName.equals("emp")){
					%>
					<h1 class="h3 mb-2 text-gray-800">직원게시판</h1>
                    <p class="mb-4">직원게시판을 작성/수정할수있습니다.</p>
					<%  
					}
					else if(boardName.equals("guard")){
					%>
					<h1 class="h3 mb-2 text-gray-800">보호자게시판</h1>
                    <p class="mb-4">보호자게시판을 작성/수정할수있습니다.</p>
					<%  
					}
					%>
                    <!-- DataTales Example -->
                    <div class="card shadow mb-4">
                        <div class="card-header py-3">
                            <h6 class="m-0 font-weight-bold text-primary">등록인원현황</h6>
                        </div>
                        <div class="card-body">
                            <div class="table-responsive">

                                <form action="calendar_write.jsp">
				<input type="hidden" name="boardName" value="<%=boardName%>"/>
<%
//현재 년/월/일을 구하기 위한 인스턴스 생성
Calendar tDay = Calendar.getInstance();

/*
파라미터가 있는 경우 : 파라미터에 해당하는 년/월을 표현
파라미터가 없는 경우 : 무조건 현재 년/월을 표현
*/
int y = (request.getParameter("y")==null) ?
    tDay.get(Calendar.YEAR) :
    Integer.parseInt(request.getParameter("y"));
int m = (request.getParameter("m")==null) ?
    tDay.get(Calendar.MONTH) :
    Integer.parseInt(request.getParameter("m"));
int d = tDay.get(Calendar.DATE);

Map<String, calendarDTO> map = new HashMap<String, calendarDTO>();

String ym="";
if(m+1>=10){
	ym = y + "-" + (m+1);
}
else{
	ym = y + "-0" + (m+1);
}

map = dao.selectC(ym);
//System.out.println(map.get("2021-12-17").getTitle()); 
//자원해제
dao.close(); 

/*
날자설정을 위한 객체생성 : 현재 년/월 그리고 1일로 설정
한다. 즉 현재월의 1일로 설정한다.
*/
Calendar dSet = Calendar.getInstance();

dSet.set(y, m, 1);//현재 년/월/1 일로 설정함
//오늘이 어떤 요일인지 구한다.
int yo = dSet.get(Calendar.DAY_OF_WEEK);
//현재월의 마지막 날자를 구한다.(7월->31, 9월->30)
int last_day = dSet.getActualMaximum(Calendar.DATE);
%>
<div align=center style="font-size: 16px; font-weight: bold;">
<a href="../calendar_list.jsp?y=<%=y-1%>&m=<%=m%>&boardName=<%=boardName%>" target="_self">
<b>&lt;&lt;</b><!-- 이전 해 -->
</a>
<%if(m > 0 ){ %>
<a href="../calendar_list.jsp?y=<%=y%>&m=<%=m-1%>&boardName=<%=boardName%>" target="_self">
<b>&lt;</b><!-- 이전 달 -->
</a>
<%} else {%>
<b>&lt;</b>
<%} %>
&nbsp;&nbsp;
<%=y%>년<%=m+1%>월
&nbsp;&nbsp;
<%if(m < 11 ){ %>
<a href="../calendar_list.jsp?y=<%=y%>&m=<%=m+1%>&boardName=<%=boardName%>" target="_self">
<b>&gt;</b><!-- 다음 달 -->
</a>
<%}else{%>
<b>&gt;</b>
<%} %>
<a href="../calendar_list.jsp?y=<%= y+1 %>&m=<%= m %>&boardName=<%=boardName%>" target="_self">
<b>&gt;&gt;</b><!-- 다음 해 -->
</a>
</div>
<!-- <%= y %>년<%= m+1 %>월 -->
<table cellpadding="0" cellspacing="0" border="1" class="calendar table" style="width:100%; height:60%">
    <colgroup>
   	 <col width="14%" />
   	 <col width="14%" />
   	 <col width="14%" />
   	 <col width="14%" />
   	 <col width="14%" />
   	 <col width="14%" />
   	 <col width="*" />
    </colgroup>
    
    <tr class="table-active">
    <%
    String[] a = { "sun", "mon", "tue", "wed", "thu", "fri", "sat" };
    for (int i = 0; i < 7; i++) {
    %>
   	 <%-- <th style="padding:5px 0;"><img src="../images/day0<%=i+1 %>.gif" alt="<%=a[i]%>" /></th> --%>
   	 <th style="padding:5px 0;"><%=a[i]%></th>
    <%
    }
    %>   	 
    </tr>
    <tr>
    <%
    for (int k = 1; k < yo; k++) {
    %>
   	 <td></td>
    <%
    }
    %>
    <%
   	int f_date;
    for (int j = 1; j <= last_day; j++) {
  		
    	String str = "";
    	if(m+1<10){
    		if(j>=10){
    			str = y + "-0" + (m+1) + "-" + j;
    		}
    		if(j<10){
    			str = y + "-0" + (m+1) + "-0" + j;
    		}
    	}
    	if(m+1>=10){
    		if(j>=10){
    			str = y + "-" + (m+1) + "-" + j;
    		}
    		if(j<10){
    			str = y + "-" + (m+1) + "-0" + j;
    		}
    	}
    	//System.out.println(str);
    %>
   	 <!-- 날짜가 출력되는 부분 <%=y%>-<%=m+1%>-<%=j%> -->
   	 <td><%=j%> 
   	 <br />
   	 <%
   		if(map.get(str)!=null){
   	 %>
	   	 <a href="calendar_view.jsp?idx=<%= map.get(str).getIdx() %>&boardName=<%=boardName%>">
	   	 <%= map.get(str).getTitle() %>
	   	 </a>
	<%}%>
   	 </td>
    <%
    	
    if ((yo+j-1) % 7 == 0) {%>
    </tr>
    <tr>
    <%
   	 }
    }
    for(int e=1;e<(7-yo)-1;e++){
    %>
   	 <td></td>
    <%
    }
    %>
    </tr>
</table>
<%
if(session.getAttribute("UserType") == null){
}
else if(session.getAttribute("UserType").equals("0"))
{
%>
	<button type="submit" class="btn btn-outline-dark">일정 등록</button>
<%} %>
	</form>
                            </div>
                            <div class="row text-right" style="padding-right:50px;">
							<!-- 각종 버튼 부분 -->
							<!-- <button type="reset" class="btn">Reset</button> -->
							<div class="container mt-3">	
							<button type="button" class="btn btn-outline-dark"  
								onclick="location.href='board_write03.jsp?boardName=<%=boardName%>';">글쓰기</button>
									
							<!-- <button type="button" class="btn btn-primary">수정하기</button>
							<button type="button" class="btn btn-success">삭제하기</button>
							<button type="button" class="btn btn-info">답글쓰기</button>
							<button type="button" class="btn btn-warning">리스트보기</button>
							<button type="submit" class="btn btn-danger">전송하기</button> -->
							</div>
                        </div>
                        
                    </div>

                </div>
                <!-- /.container-fluid -->

            </div>
            <!-- End of Main Content -->

    </div>
    <!-- End of Page Wrapper -->

    <!-- Scroll to Top Button-->
    <a class="scroll-to-top rounded" href="#page-top">
        <i class="fas fa-angle-up"></i>
    </a>

    <!-- Logout Modal-->
    <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
        aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">×</span>
                    </button>
                </div>
                <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
                <div class="modal-footer">
                    <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
                    <a class="btn btn-primary" href="login.jsp">Logout</a>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap core JavaScript-->
    <script src="vendor/jquery/jquery.min.js"></script>
    <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

    <!-- Core plugin JavaScript-->
    <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

    <!-- Custom scripts for all pages-->
    <script src="js/sb-admin-2.min.js"></script>

</body>

</html>