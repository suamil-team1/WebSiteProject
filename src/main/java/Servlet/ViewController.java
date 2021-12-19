package Servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;

@WebServlet("/community/View.do")
public class ViewController extends HttpServlet {

		@Override
		protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
				throws ServletException, IOException {
			
			//DB 연결
			ProjectBoardDAO2 dao = new ProjectBoardDAO2();			
			
			String idx = req.getParameter("idx");
			
			//조회수 증가
			dao.updateVisitCount(idx);
			//게시물 조회
			ProjectBoardDTO dto = dao.selectView(idx);
			//자원 반납
			dao.close();
			//줄바꿈 처리를 위한 변환
			dto.setContent(dto.getContent().replaceAll("\r\n", "<br>"));
			
			//request영역에 DTO객체 저장
			req.setAttribute("dto", dto);
			//View로 포워드
			req.getRequestDispatcher("/model2/sub01.jsp").forward(req, resp);
		}
}
