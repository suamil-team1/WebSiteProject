package model.projectboard;

import java.util.HashMap;
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
                    + "(id, title, content, pdate, boardName)"
                    + "values(? , ? , ?, ?, ?)";

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

	//해당 날짜 title출력 메서드
	public Map<String, calendarDTO> selectC(String param) { 
	    
		//Map컬렉션 생성 //리턴변수
		Map<String, calendarDTO> map = new HashMap<String, calendarDTO>();  

        //쿼리문
        String query = "SELECT bd.* , to_char(pdate, 'yyyy-mm-dd') pd "
        		+ " FROM Model2BoardCal bd WHERE boardName='cal' "
        		+ " AND to_char(pdate, 'yyyy-mm')='"+ param +"'"; 
        System.out.println(query);

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
                dto.setPdate(rs.getString("pd"));  
                dto.setBoardName(rs.getString("boardName"));  
                //dto.setEmail(rs.getString("email"));
                //dto.setName(rs.getString("name"));
                
                //map.put(rs.getString("pdate"), dto);
                map.put(rs.getString("pd"), dto); //value 값 얻기
                
                //System.out.println(rs.getString("pd")+rs.getString("title")); 
            }
           
        } 
        catch (Exception e) {
            System.out.println("게시물 조회 중 예외 발생");
            e.printStackTrace();
        }
        return map;
    }
	
	//상세보기를 위해 특정 일련번호에 해당하는 게시물을 인출한다. 
    public calendarDTO selectView(String idx) { 
        
    	calendarDTO dto = new calendarDTO(); 
        
        String query = "SELECT"
        		+ " idx, C.id, title, content, pdate, boardName, to_char(pdate, 'yyyy-mm-dd') pd "
        		+ " FROM Model2BoardCal C inner join Projectmember M "
        		+ " on C.id=M.id "
                + " WHERE idx=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);   
            rs = psmt.executeQuery();  

            if (rs.next()) { 
            	dto.setIdx(rs.getString("idx"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));  
                dto.setContent(rs.getString("content"));   
                dto.setPdate(rs.getString("pd"));
                //dto.setEmail(rs.getString("email"));
                //dto.setName(rs.getString("name"));
            }
        } 
        catch (Exception e) {
            System.out.println("게시물 상세보기 중 예외 발생");
            e.printStackTrace();
        }
        return dto; 
    }
    
  //게시물 수정
  	public int updateEdit(calendarDTO dto) {
  		
  		int result=0; //확인용 변수
  		
  		try { //쿼리문
  			String query = "UPDATE Model2BoardCal SET " 
    				  + " title=?, content=?, pdate=? "
                      + " WHERE idx=?";
  			
  			psmt = con.prepareStatement(query);
  			psmt.setString(1, dto.getTitle());
  			psmt.setString(2, dto.getContent());
  			psmt.setString(3, dto.getPdate());
  			psmt.setString(4, dto.getIdx());
  			//쿼리 실행
  			result = psmt.executeUpdate();
  		}
  		catch (Exception e) {
  			System.out.println("게시물 수정 중 예외 발생");
  			e.printStackTrace();
  		}	
  		return result;
  	}
}

