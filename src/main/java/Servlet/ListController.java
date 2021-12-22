package Servlet;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.projectboard.ProjectBoardDAO2;
import model.projectboard.ProjectBoardDTO;
import utilss.BoardPage;

@WebServlet("/Model2Board/List.do")
public class ListController extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) 
			throws ServletException, IOException {
		
		//DB 연결
		ProjectBoardDAO2 dao = new ProjectBoardDAO2();
		
		Map<String, Object> map = new HashMap<String, Object>();
		
		//검색어 파라미터 받기
		String searchField = req.getParameter("searchField");
		String searchWord = req.getParameter("searchWord");
		
		//검색어를 입력했을때 파라미터 저장
		if(searchWord != null) {
			map.put("searchField", searchField);
			map.put("searchWord", searchWord);
		}
		
		//게시물의 개수를 카운트
		int totalCount = dao.selectCount(map);
		
		ServletContext application = getServletContext();
		
		//페이지당 게시물 수 & 블록 당 페이지 수
		int pageSize = Integer.parseInt(application.getInitParameter("POSTS_PER_PAGE"));
		int blockPage = Integer.parseInt(application.getInitParameter("PAGES_PER_BLOCK"));
		//페이지 수
		int pageNum = 1;
		//파라미터로 받아온 페이지 수
		String pageTemp = req.getParameter("pageNum");
		//파라미터 값 검증 후 페이지수 변경
		if(pageTemp != null && !pageTemp.equals(""))
			pageNum = Integer.parseInt(pageTemp);
		
		//페이지 내 첫번째 게시물의 번호
		int start = (pageNum -1) * pageSize + 1;
		//페이지 내 마지막 게시물의 번호
		int end = pageNum * pageSize;
		
		map.put("start", start);
		map.put("end", end);
		
		//현재 페이지에 출력할 게시물을 DB에서 가져온다.
		List<ProjectBoardDTO> boardLists = dao.selectList(map);
		dao.close();
		
		String pagingImg = BoardPage.pagingStr(totalCount, pageSize, blockPage, pageNum, 
				"../mvcboard/list.do");
		
		
	}
}
















