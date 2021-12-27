package member;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.CookieManager;
import util.JSFunction;

@WebServlet("/adminpage/login.do")
public class AdminLoginProcess extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.getRequestDispatcher("/adminpage/login.jsp").forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String userId = req.getParameter("id");
		String userPwd = req.getParameter("pass");
		String saveEmail = req.getParameter("save_check");
		
		ProjectMemberDAO dao = new ProjectMemberDAO();
		ProjectMemberDTO dto = dao.getMemberDTO(userId, userPwd);
		
		dao.close();
		
		if(dto.getId() != null){ 
			HttpSession session = req.getSession();
			session.setAttribute("UserId", dto.getId());
			session.setAttribute("UserName", dto.getName());
			session.setAttribute("UserEmail", dto.getEmail());
			session.setAttribute("UserType", dto.getType());
			
			//아이디 쿠키에 저장하기.
			if(saveEmail != null && saveEmail.equals("Y")){
				//쿠키를 저장한다. 쿠키값은 로그인아이디, 유효기간은 1일로 설정한다.
				CookieManager.makeCookie(resp, "loginEmail", userId, 86400);
			}
			else{
				//로그인 성공하고, 아이디 저장 체크를 하지 않았다면 쿠키를 삭제한다.
				CookieManager.deleteCookie(resp, "loginEmail");
			}
			resp.sendRedirect("index.jsp");
		}
		else{
			req.setAttribute("LoginErrMsg", "로그인 오류입니다.");
			req.getRequestDispatcher("../adminpage/login.jsp").forward(req, resp);
		}

		
	}
}
