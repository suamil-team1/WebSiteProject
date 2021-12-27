package model.projectboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import connect.DBConnPool;


public class ProjectBoardDAO2 extends DBConnPool{
	
	//게시물의 총 개수 계산(Paging)
	public int selectCount(Map<String, Object> map) {
		
		int totalCount = 0;
		
		String boardName = (String)map.get("boardName");
		
		String query = "SELECT COUNT(*) FROM Model2Board WHERE boardName LIKE '%"
					+ boardName +"%'";
		if(map.get("keyString") !=null) {
			query += " AND " + map.get("keyField")+" "
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
		
		String boardName = (String)map.get("boardName");
		
		String query = "SELECT * FROM Model2Board JOIN Projectmember USING(id) ";	
		//검색어가 있을때
		if(map.get("keyString") !=null) {
			query += " WHERE "+ map.get("keyField")
					+ " LIKE '%" + map.get("keyString") + "%' " 
					+ " AND boardName LIKE '%" + boardName + "%' ";
		}
		else {
			query += " WHERE boardName LIKE '%"+ boardName +"%' ";
		}
		
		query += " ORDER BY idx DESC LIMIT ?, ?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));

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
				dto.setType(rs.getString("type"));
				
				pBoard.add(dto);
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
		String query = "SELECT * FROM Projectmember JOIN Model2Board "
					+ " USING(id) WHERE idx=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			rs = psmt.executeQuery();
			
			if(rs.next()) {
				dto.setIdx(rs.getString("idx"));
				dto.setId(rs.getString("id"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));
				dto.setEmail(rs.getString("email"));
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
						+ " title, content, ofile, sfile, id, boardname) "
						+ " VALUES (?,?,?,?,?,?)";
			
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());	
			psmt.setString(5, dto.getId());
			psmt.setString(6, dto.getBoardName());
			
			//쿼리문 실행 : 입력에 성공하면 1, 실패하면 0.
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 입력 중 예외 발생");
			e.printStackTrace();
		}		
		return result;
	}
	
	//idx에 해당하는게시물 삭제
	public int deletePost(String idx) {
		
		int result = 0;
		try {
			String query = "DELETE FROM Model2Board WHERE idx=?";
			psmt = con.prepareStatement(query);
			psmt.setString(1, idx);
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 삭제 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//게시물 수정
	public int updatePost(ProjectBoardDTO dto) {
		
		int result = 0;
		
		try {
			String query = "UPDATE Model2Board "
					+ " SET title=?, content=?, ofile=?, sfile=? "
					+ " WHERE idx=?";
			
			//prepared 객체 생성
			psmt = con.prepareStatement(query);
			//인파라미터 설정		
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getOfile());
			psmt.setString(4, dto.getSfile());
			psmt.setString(5, dto.getIdx());
			//쿼리 실행
			result = psmt.executeUpdate();
		}
		catch(Exception e) {
			System.out.println("게시물 수정 중 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	//접근 권한 확인(CheckIn)
	public int checkingAccess(String UserId) {
		
		int typeNum = -1;
		
		try {
			String query = "select type from Projectmember join Model2Board "
							+ " using(id) where id="+ UserId;			
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			typeNum = rs.getInt(1);
		}
		catch(Exception e) {
			System.out.println("멤버 type 확인 중 예외 발생");
			e.printStackTrace();
		}
		return typeNum;
	}
}
