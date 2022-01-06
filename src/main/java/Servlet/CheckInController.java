package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import member.ProjectMemberDAO;
import member.ProjectMemberDTO;
import model.projectboard.ProjectBoardDAO2;
import util.IsLogIn;
import util.JSFunction;

@WebServlet("/community/CheckIn.do")
public class CheckInController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String boardName = req.getParameter("boardName");
		
		//IsLogIn.isLogIn(req, resp); => 에러발생. 해결요망
		
		//세션 영역에서 아이디를 가져온다.
		HttpSession session = req.getSession();
		String UserId = (String)session.getAttribute("UserId"); 
		
		//세션영역에 아이디가 저장되어있지 않는 경우
		if(UserId==null || UserId=="") {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../member/login.do");			
			return;
		}
		
		//회원의 type 확인(권한 확인)		
		//직원 게시판인 경우(직원/관리자 권한만 접근, 수정 가능)
		if(req.getParameter("boardName").equals("emp")) {
			
			ProjectBoardDAO2 dao = new ProjectBoardDAO2();
//			session.setAttribute("UserType", memberDTO.getType());
			
			//int typeNum = dao.checkingAccess(UserId);
			dao.close();
			
			if(session.getAttribute("UserType").equals("2")) {
				
				JSFunction.alertBack(resp, "이용할 수 없는 게시판 입니다.");
				return;
			}
			else {
				resp.sendRedirect("../community/List.do?boardName="+boardName);
			}
		}
		//보호자 게시판인 경우(모든 회원 접근, 수정 가능)	
		else if(req.getParameter("boardName").equals("prt")) {
			resp.sendRedirect("../community/List.do?boardName="+boardName);
		}
	}
}
