package Servlet;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;
import util.FileUtil;
import util.JSFunction;

@WebServlet("/community/Edit.do")
public class EditController extends HttpServlet {
	
	//기존 내용을 불러와서 수정 페이지 진입.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String idx = req.getParameter("idx");
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		//게시물 가져오기
		ProjectBoardDTO dto = dao.selectView(idx);
		dao.close();
		dto.setContent(dto.getContent().replaceAll("<br/>", "\r\n"));
		//게시물이 담긴 DTO 객체를 리퀘스트 영역에 저장
		req.setAttribute("dto", dto);
		req.setAttribute("bCRUD", "edit");
		req.getRequestDispatcher("/community/sub01.jsp").forward(req, resp);		
	}
	
	//수정한 내용 입력.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		//디렉토리의 물리적 경로 획득
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		//최대 업로드 용량 설정
		ServletContext application = this.getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		//파일 업로드
		MultipartRequest mr 
			= FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		//업로드에 실패한 경우
		if(mr == null) {
			JSFunction.alertLocation(resp, "3mb 이하의 파일만 업로드 가능합니다.", 
								"../community/Edit.do");
			return;
		}
		
		//파일을 새로 등록하지 않은 경우 기존 파일명을 다시 저장
		String idx = mr.getParameter("idx");
		String prevOfile = mr.getParameter("prevOfile"); //기존 DB에 등록된 원본파일명
		String prevSfile = mr.getParameter("prevSfile"); //기존 DB에 등록된 저장파일명
		
		
	}
}
