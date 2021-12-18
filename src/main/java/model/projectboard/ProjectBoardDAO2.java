package model.projectboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import connect.JDBConnect;


public class ProjectBoardDAO2 extends JDBConnect{
	
	public int selectCount(Map<String, Object> map) {
		int totalCount = 0;
		String query = "SELECT COUNT(*) FROM Model2Board";
		if(map.get("searchWord") !=null) {
			query += " WHERE " + map.get("searchField")+" "
					+ " LIKE '%" +map.get("searchWord") + "%'";
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
	
	
	public List<ProjectBoardDTO> selectList(Map<String, Object> map) {
		
		List<ProjectBoardDTO> pBoard = new Vector<ProjectBoardDTO>();
		
		String query = "SELECT * FROM ( "
					+ "		SELECT Tb.*, ROWNUM rNum FROM ( "
					+ "			SELECT * FROM Model2Board ";		
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
				dto.setName(rs.getString("name"));
				dto.setPostdate(rs.getDate("postdate"));
				dto.setVisitcount(rs.getInt("visitcount"));
				dto.setOfile(rs.getString("ofile"));
				dto.setSfile(rs.getString("sfile"));

				pBoard.add(dto);
			}
		}
		catch(Exception e) {
			System.out.println("게시물 조회 중 예외 발생");
			e.printStackTrace();
		}	
		return pBoard;
	}
}
