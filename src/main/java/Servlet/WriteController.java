package Servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import model.projectboard.ProjectBoardDTO;
import util.FileUtil;
import util.JSFunction;



@WebServlet("/community/Write.do")
public class WriteController extends HttpServlet {
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//글쓰기 페이지로 이동
		req.getRequestDispatcher("/community/sub01.jsp").forward(req, resp);
		req.setAttribute("bCRUD", "write");
	}
	
	//글쓰기 제어
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//디렉토리의 물리적 경로 획득
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		//최대 업로드 용량 설정
		ServletContext application = getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		//파일 업로드 처리
		MultipartRequest mr 
			= FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		//업로드에 실패한 경우
		if(mr == null) {
			JSFunction.alertLocation(resp, "첨부 파일이 제한 용량을 초과합니다.", 
								"../community/Write.do");
			return;
		}
		
		ProjectBoardDTO dto = new ProjectBoardDTO();
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		/* dto.setContent(mr.getParameter("email")); */
		dto.setPass(mr.getParameter("ofile"));
	}
}














