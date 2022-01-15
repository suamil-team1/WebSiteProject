package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.CookieManager;
import util.JSFunction;

@WebServlet("/member/login.do")
public class LoginProcess extends HttpServlet{

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/member/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userId = req.getParameter("id"); 
		String userPwd = req.getParameter("pass");
		String saveId = req.getParameter("saveId");
		
		
		ProjectMemberDAO dao = new ProjectMemberDAO();
		ProjectMemberDTO memberDTO = dao.getMemberDTO(userId, userPwd);
		
		dao.close();
		
		if(memberDTO.getId() != null){ 
			HttpSession session = req.getSession();
			session.setAttribute("UserId", memberDTO.getId());
			session.setAttribute("UserName", memberDTO.getName());
			session.setAttribute("UserType", memberDTO.getType());
			
			//아이디 쿠키에 저장하기.
			if(saveId!=null && saveId.equals("Y")) {
				CookieManager.makeCookie(resp, "loginId", userId, 86400);
            }else {
            	CookieManager.deleteCookie(resp, "loginId");
            }
			resp.sendRedirect("../member/login.jsp");
		}
		else{
			req.setAttribute("LoginErrMsg", "로그인 오류입니다.");
			req.getRequestDispatcher("../main/main.jsp").forward(req, resp);
		}

		
	}
}
