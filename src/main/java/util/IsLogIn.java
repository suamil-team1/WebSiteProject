package util;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class IsLogIn {
	
	public static void isLogIn(HttpServletRequest req, HttpServletResponse resp) {
		
		//세션 영역에서 아이디를 가져온다.
		HttpSession session = req.getSession();
		String UserId = (String)session.getAttribute("UserId"); 
		
		//세션영역에 아이디가 저장되어있지 않는 경우
		if(UserId==null || UserId=="") {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../member/login.do");			
			return;
		}
	}
}
