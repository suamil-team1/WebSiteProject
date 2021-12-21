package model.projectboard;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import connect.JDBConnect;

public class calendarDAO extends JDBConnect{
	
	public calendarDAO(ServletContext application) {
        super(application);
    }
	
	//Calendar 입력 //sub02
	public int insertWrite(calendarDTO dto) {

        int result = 0; //확인을 위한 변수

        try {
            //동적 쿼리
            String query = "insert into Model2BoardCal"
                    + "(idx, id, title, content, pdate, boardName)"
                    + "values(seq_prtBoard_idx.NEXTVAL, ? , ? , ?, ?, ?)";

            //동적쿼리문
            psmt = con.prepareStatement(query);
            //인파라미터 설정 
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getPdate());
            psmt.setString(5, dto.getBoardName());

            result = psmt.executeUpdate();//성공 시 1반환
        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }
//	
//	//게시물의 갯수 카운트하기
//		public int selectCount(Map<String, Object> map){
//			int totalCount=0;//카운트 변수
//			
//			//쿼리문 작성
//			String query = " SELECT COUNT(*) FROM Model2Board";
//			//검색어가 있는 경우
//			if(map.get("searchWord") != null) {
//				query += " WHERE " + map.get("searchField") +" "
//						+" LIKE '%" + map.get("searchWord") + "%' ";
//			}
//			
//			try {
//				//정적쿼리문 실행 객체 생성
//				stmt = con.createStatement();
//				rs = stmt.executeQuery(query);
//				rs.next();
//				
//				//결과값을 변수에 저장
//				totalCount = rs.getInt(1);
//			}
//			catch (Exception e) {
//				System.out.println("게시물 수를 구하는 중 예외 발생");
//				e.printStackTrace();
//			}
//			
//			return totalCount;
//		}
	//해당 날짜 title출력 메서드
	public HashSet<calendarDTO> select(Map<String, Object> map) { 
	    
		//List컬렉션 생성 
		HashSet bbs = new HashSet<calendarDTO>();  

        //쿼리문
        String query = "SELECT title FROM Model2BoardCal "; 

        try {
            stmt = con.createStatement();    
            rs = stmt.executeQuery(query);  

            //결과 반복
            while (rs.next()) { 
            	
            	//레코드 읽기 dto객체 생성
            	calendarDTO dto = new calendarDTO(); 

                dto.setIdx(rs.getString("idx"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));      
                dto.setContent(rs.getString("content"));   
                dto.setPdate(rs.getString("pdate"));  
                dto.setBoardName(rs.getString("boardName"));  
                //dto.setEmail(rs.getString("email"));
                //dto.setName(rs.getString("name"));
                
                bbs.add(dto); //dto에 추가  
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return bbs;
    }
}

