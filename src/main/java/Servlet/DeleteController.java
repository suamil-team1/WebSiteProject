package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import fileupload.FileUtil;
import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;
import util.JSFunction;

@WebServlet("/community/Delete.do")
public class DeleteController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String boardName = req.getParameter("boardName");
		String idx = req.getParameter("idx");
		
		/* 아이디 검증 */
		//세션 영역에서 아이디를 가져온다.
		HttpSession session = req.getSession();
		String UserId = (String)session.getAttribute("UserId"); 
		
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		//삭제할 게시물이 있는지 확인
		ProjectBoardDTO dto = dao.selectView(idx);
		//작성자의 아이디를 가져옴
		String id = dto.getId();
		//작성자의 아이디와 접속한 아이디를 대조
		if(!(UserId.equals(id))) {
			JSFunction.alertBack(resp, "해당 게시물은 작성자만 삭제 가능합니다.");
			return; //이거 삭제하면 아래까지 실행되니 조심
		}
		//게시물 삭제
		int result = dao.deletePost(idx);
		dao.close();
		
		//게시물 삭제 성공했을때
		if(result == 1) {
			String saveFileName = dto.getSfile();
			FileUtil.deleteFile(req, "/Uploads", saveFileName);	
			
			JSFunction.alertLocation(resp, "해당 게시물이 삭제되었습니다.", "../community/CheckIn.do?boardName="+boardName);
			
			return;
		}
		else {
			JSFunction.alertBack(resp, "게시물을 삭제할 수 없습니다.");
		}
	}
}
