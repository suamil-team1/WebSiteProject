package Servlet;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;

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
		
		String name = mr.getParameter("name");
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		
		//DTO에 데이터 세팅
		ProjectBoardDTO dto = new ProjectBoardDTO(); 
		dto.setIdx(idx);
		dto.setTitle(title);
		dto.setContent(content);
		/** 이메일 입력 **/
		
		//새로 저장하는 파일이 있는지 검증
		String fileName = mr.getFilesystemName("ofile");
		//새롭게 저장된 파일이 있는 경우
		if(fileName !=null) {
			//새로 저장할 파일명의 서버에 저장할 이름을 생성
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newfileName = now + ext;
			//파일명을 변경
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newfileName);
			oldFile.renameTo(newFile);
			//DTO에 기존파일명과 변경된 파일명 저장
			dto.setOfile(fileName);
			dto.setSfile(newfileName);
			//새로운 파일이 등록되었으므로 기존에 등록한 파일은 삭제처리
			FileUtil.deleteFile(req, "/Uploads", prevSfile);
		}
		//새롭게 저장한 파일이 없는경우
		else {
			//기존에 등록한 파일명으로 다시 저장(유지)
			dto.setOfile(prevOfile);
			dto.setSfile(prevSfile);
		}
		
		//DB 업데이트 단계
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		int result = dao.updatePost(dto);
		dao.close();
		
		//수정에 성공한 경우
		if(result==1) {
			resp.sendRedirect("../community/view.do?idx="+idx);
		}
		//수정에 실패한 경우
		else {
			JSFunction.alertLocation(resp, "수정에 실패했습니다.",
					"../community/view.do?idx="+idx);
		}
	}
}
