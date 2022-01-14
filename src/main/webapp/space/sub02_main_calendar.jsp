<%@page import="java.util.Calendar"%>
<%@page import="java.util.HashSet"%>
<%@page import="model.projectboard.calendarDTO"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.projectboard.calendarDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String boardName = request.getParameter("boardName");
  
//db연결
calendarDAO dao = new calendarDAO(application);

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
<%-- <div align=center style="font-size: 16px; font-weight: bold;">
<a href="./sub02.jsp?y=<%=y-1%>&m=<%=m%>&boardName=<%=boardName%>" target="_self">
<b>&lt;&lt;</b><!-- 이전 해 -->
</a>
<%if(m > 0 ){ %>
<a href="./sub02.jsp?y=<%=y%>&m=<%=m-1%>&boardName=<%=boardName%>" target="_self">
<b>&lt;</b><!-- 이전 달 -->
</a>
<%} else {%>
<b>&lt;</b>
<%} %>
&nbsp;&nbsp;
<%=y%>년<%=m+1%>월
&nbsp;&nbsp;
<%if(m < 11 ){ %>
<a href="./sub02.jsp?y=<%=y%>&m=<%=m+1%>&boardName=<%=boardName%>" target="_self">
<b>&gt;</b><!-- 다음 달 -->
</a>
<%}else{%>
<b>&gt;</b>
<%} %>
<a href="./sub02.jsp?y=<%= y+1 %>&m=<%= m %>&boardName=<%=boardName%>" target="_self">
<b>&gt;&gt;</b><!-- 다음 해 -->
</a>
</div> --%>
<!-- <%= y %>년<%= m+1 %>월 -->
<table cellpadding="0" cellspacing="0" class="calendar table" style="width:299px; height:60%; margin-left: 0px">
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
	   	 <a href="../space/sub02_view.jsp?idx=<%= map.get(str).getIdx() %>&boardName=cal" 
	   	 	style="overflow:hidden;text-overflow:ellipsis; white-space:nowrap; display: block; width:40px">
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
<%-- <%
if(session.getAttribute("UserType") == null){
}
else if(session.getAttribute("UserType").equals("0"))
{
%>
	<button type="submit" class="btn btn-outline-dark">일정 등록</button>
<%} %> --%>
