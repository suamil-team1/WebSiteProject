package model.projectboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import common.JDBConnect;

public class projectboardDAO extends JDBConnect{
	
	public projectboardDAO(ServletContext application) {
    	//내장객체를 통해 web.xml에 작성된 컨텍스트 초기화 파라미터를 얻어온다.
        super(application);
    }
	
	public List<projectboardDTO2> selectList(Map<String, Object> map) { 
	    	
	    	/*
	    	board테이블에서 select한 결과데이터를 저장하기 위한 리스트 컬렉션.
	    	여러가지의 List컬렉션 중 동기화가 보장되는 Vector를 사용한다. 
	    	 */
	        List<projectboardDTO2> bbs = new Vector<projectboardDTO2>();  
	
	        /*
	        목록에 출력할 게시물을 추출하기 위한 쿼리문으로 항상 일련번호의 
	        역순(내림차순)으로 정렬해야 한다. 게시판의 목록은 최근 게시물이
	        제일 앞에 노출되기 때문이다. 
	         */
	        String query = "SELECT * FROM Projectboard "; 
	        //검색어가 있는경우 where절을 추가한다. 
	        if (map.get("searchWord") != null) {
	            query += " WHERE " + map.get("searchField") + " "
	                   + " LIKE '%" + map.get("searchWord") + "%' ";
	        }
	        query += " ORDER BY idx DESC "; 
	
	        try {
	            stmt = con.createStatement();    
	            rs = stmt.executeQuery(query);  
	
	            //추출된 결과에 따라 반복한다. 
	            while (rs.next()) { 
	            	//하나의 레코드를 읽어서 DTO객체에 저장한다. 
	            	projectboardDTO2 dto = new projectboardDTO2(); 
	
	                dto.setIdx(rs.getString("idx"));          
	                dto.setId(rs.getString("id"));          
	                dto.setName(rs.getString("name"));          
	                dto.setEmail(rs.getString("email"));          
	                dto.setTitle(rs.getString("title"));      
	                dto.setContent(rs.getString("content"));   
	                dto.setPostdate(rs.getDate("postdate"));  
	                dto.setOfile(rs.getString("ofile"));           
	                dto.setSfile(rs.getString("sfile")); 
	                dto.setPass(rs.getString("pass"));  
	                dto.setVisitcount(rs.getInt("visitcount"));  
	                
	                //리스트 컬렉션에 DTO객체를 추가한다. 
	                bbs.add(dto);  
	            }
	        } 
	        catch (Exception e) {
	            System.out.println("게시물 조회 중 예외 발생");
	            e.printStackTrace();
	        }
	        return bbs;
	    }
	
	
	//사용자가 입력한 내용을 board테이블에 insert 처리하는 메서드
    public int insertWrite(projectboardDTO2 dto) {
        //입력결과 확인용 변수
    	int result = 0;
        
        try {
        	//인파라미터가 있는 쿼리문 작성(동적쿼리문)
            String query = "INSERT INTO Projectboard ( "
                         + " idx, name, email, pass, title, content, visitcount) "
                         + " VALUES ( "
                         + " seq_board_num.NEXTVAL, ?, ?, ?, ?, ?, 0)";  
            //동적쿼리문 실행을 위한 prepared객체 생성
            psmt = con.prepareStatement(query);   
            //순서대로 인파라미터 설정
            psmt.setString(1, dto.getName());  
            psmt.setString(2, dto.getEmail());
            psmt.setString(3, dto.getPass());  
            psmt.setString(4, dto.getTitle());  
            psmt.setString(5, dto.getContent());  
            //쿼리문 실행 : 입력에 성공한다면 1이 반환된다. 실패시 0반환.
            result = psmt.executeUpdate(); 
        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        
        return result;
    }
}
