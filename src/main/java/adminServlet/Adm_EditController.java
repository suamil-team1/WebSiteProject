package adminServlet;

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
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.ParamPart;

import fileupload.FileUtil;
import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;
import util.JSFunction;

@WebServlet("/adminpage/Edit.do")
public class Adm_EditController extends HttpServlet {
	
	//기존 내용을 불러와서 수정 페이지 진입.
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		String boardName = req.getParameter("boardName");
		String idx = req.getParameter("idx");
		
		/* 로그인 확인 */
		//세션 객체(로그인된 아이디)를 가져온다.
		HttpSession session = req.getSession();
		String UserId = (String)session.getAttribute("UserId"); 		
		//세션영역에 아이디가 저장되어있지 않는 경우
		if(UserId==null || UserId=="") {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../member/login.do");			
			return;
		}		
		
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		//게시물 가져오기
		ProjectBoardDTO dto = dao.selectView(idx);
		dao.close();
		
		dto.setContent(dto.getContent().replaceAll("<br>", "\r\n"));
		//게시물이 담긴 DTO 객체를 리퀘스트 영역에 저장
		req.setAttribute("dto", dto);
		req.setAttribute("bCRUD", "edit");
		
		if(boardName.equals("emp"))
			req.getRequestDispatcher("/adminpage/board2_list.jsp?boardName="+boardName).forward(req, resp);
		else if(boardName.equals("prt"))
			req.getRequestDispatcher("/adminpage/board2_list.jsp?boardName="+boardName).forward(req, resp);		
	}
	
	//수정한 내용 입력.
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		/* 로그인 확인 */
		//세션 객체를 가져온다.
		HttpSession session = req.getSession();
		String UserId = (String)session.getAttribute("UserId"); 
		String UserType = (String)session.getAttribute("UserType"); 
		
		//세션영역에 아이디가 저장되어있지 않는 경우
		if(UserId==null || UserId=="") {
			JSFunction.alertLocation(resp, "로그인 후 이용해주세요.", 
					"../member/login.do");			
			return;
		}	
		
		/* 아이디 검증 */
		//리퀘스트 영역에 저장된 객체(작성자 아이디)를 가져온다.
		String id = (String)session.getAttribute("id");
		session.removeAttribute("id");
		//관리자검증
		String type = (String)session.getAttribute("type");
		session.removeAttribute("type");
		
		//로그인된 아이디와 작성자의 아이디가 다를경우
		/*
		 * if(!(UserId.equals(id))|| !(session.getAttribute("type").equals("0"))) {
		 * 
		 * JSFunction.alertBack(resp, "해당 게시물은 작성자만 수정할 수 있습니다."); return; }
		 */
		
		//디렉토리의 물리적 경로 획득
		String saveDirectory = req.getServletContext().getRealPath("/Uploads");
		//최대 업로드 용량 설정
		ServletContext application = this.getServletContext();
		int maxPostSize = Integer.parseInt(application.getInitParameter("maxPostSize"));
		//파일 업로드
		MultipartRequest mr = FileUtil.uploadFile(req, saveDirectory, maxPostSize);
		//업로드에 실패한 경우(뒤로 이동)
		if(mr == null) {
			JSFunction.alertBack(resp, "첨부 파일이 제한 용량을 초과합니다.");
			return;
		}
				
		//파일을 새로 등록하지 않은 경우 기존 파일명을 다시 저장
		String prevOfile = mr.getParameter("prevOfile"); //기존 DB에 등록된 원본파일명
		String prevSfile = mr.getParameter("prevSfile"); //기존 DB에 등록된 저장파일명		

		ProjectBoardDTO dto = new ProjectBoardDTO(); 
		//DTO에 데이터 세팅
		dto.setIdx(mr.getParameter("idx"));
		dto.setTitle(mr.getParameter("title"));
		dto.setContent(mr.getParameter("content"));
		dto.setBoardName(mr.getParameter("boardName"));
		dto.setId(id);
		
		//새로 저장하는 파일이 있는지 검증
		String fileName = mr.getFilesystemName("ofile");
		//새롭게 저장된 파일이 있는 경우
		if(fileName !=null) {
			//임시 파일명 생성
			String now = new SimpleDateFormat("yyyyMMdd_HmsS").format(new Date());
			String ext = fileName.substring(fileName.lastIndexOf("."));
			String newfileName = now + ext;
			//파일명을 변경
			File oldFile = new File(saveDirectory + File.separator + fileName);
			File newFile = new File(saveDirectory + File.separator + newfileName);
			oldFile.renameTo(newFile);
			//파일명 저장
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
		
		//새로운 게시물을 DB 테이블에 저장
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		int result = dao.updatePost(dto);
		dao.close();
		
		
		String boardName = mr.getParameter("boardName");
		String idx = mr.getParameter("idx");
		//수정에 성공한 경우
		if(result==1) {
			resp.sendRedirect("../adminpage/View.do?boardName="+boardName+"&idx="+idx);
		}
		//수정에 실패한 경우
		else {
			JSFunction.alertLocation(resp, "수정에 실패했습니다.",
					"../adminpage/View.do?boardName="+boardName+"&idx="+idx);
		}
	}
}







