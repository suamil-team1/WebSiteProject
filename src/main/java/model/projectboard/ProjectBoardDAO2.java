package model.projectboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import connect.DBConnPool;



public class ProjectBoardDAO2 extends DBConnPool{
	
	//게시물의 총 개수 계산(Paging)
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM Model2Board";
		if(map.get("keyString") !=null) {
			query += " WHERE " + map.get("keyField")+" "
					+ " LIKE '%" +map.get("keyString") + "%'";
		}
		
		try {
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			totalCount = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("게시물 수를 구하는 중 예외발생");
			e.printStackTrace();
		}		
		return totalCount;
	}
	
	//필요한 조건의 게시물을 꺼냄(paging처리 O)(List)
	public List<ProjectBoardDTO> selectList(Map<String, Object> map) {
		
		List<ProjectBoardDTO> pBoard = new Vector<ProjectBoardDTO>();
		
		String query = "SELECT * FROM ( "
					+ "		SELECT Tb.*, ROWNUM rNum FROM ( "
					+ "			SELECT * FROM Model2Board ";	
		//검색어가 있을때
		if(map.get("keyString") !=null) {
			query += " WHERE "+ map.get("keyField")
					+ " LIKE '%" + map.get("keyString") + "%' ";
		}
		
		query += " 		ORDER BY idx DESC "
				+ "		) Tb "
				+ " ) "
				+ " WHERE rNum BETWEEN ? AND ?";
		
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("start").toString());
			psmt.setString(2, map.get("end").toString());

			rs = psmt.executeQuery();
			
			while(rs.next()) {
				ProjectBoardDTO dto = new ProjectBoardDTO();
				
				
				dto.setIdx(rs.getString("idx"));
				dto.setTitle(rs.getString("title"));
				dto.setId(rs.getString("id"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setBoardName(rs.getString("boardName"));
				
				pBoard.add(dto);
				
				System.out.println(rs.getString("idx"));
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}	
		return pBoard;
	}
	
	//게시물 클릭수 증가(List, View)
	public void updateVisitCount(String idx) {
		String query = "UPDATE Model2Board SET "
				+ " visitcount=visitcount+1 "
				+ " WHERE idx=?"; 
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			psmt.executeQuery();
		}
		catch(Exception e) {
			System.out.println("게시물 조회수 증가 중 예외발생");
			e.printStackTrace();
		}
	}
	
	//게시물 찾아서 반환(View).
	public ProjectBoardDTO selectView(String idx) {
		
		ProjectBoardDTO dto = new ProjectBoardDTO();
		String query = "SELECT * FROM Model2Board WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPostdate(rs.getDate("postdate"));
				/*** 이메일 추가 ***/
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
			}
		}
		catch(Exception e) {
			System.out.println("게시물 상세보기 중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	//새로운 게시물 입력
	public int insertWrite(ProjectBoardDTO dto) {
		int result = 0;
		
		try {
			String query = "INSERT INTO Model2Board ( "
						+ " title, content, ofile, sfile) "
						+ " VALUES (seq_empBoard_idx.NEXTVAL,?,?,?,?)";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());			
			
			//쿼리문 실행 : 입력에 성공하면 1, 실패하면 0.
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}		
		return result;
	}
}
