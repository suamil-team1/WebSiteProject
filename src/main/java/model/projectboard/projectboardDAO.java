package model.projectboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import connect.JDBConnect;

public class projectboardDAO extends JDBConnect{
	
	
	public projectboardDAO() {} //기본생성자
	public projectboardDAO(ServletContext application) {
        super(application);
    }
	
	//게시물의 갯수 카운트하기
	public int selectCount(Map<String, Object> map, String brdName){
		int totalCount=0;//카운트 변수
		
		//쿼리문 작성
		String query = " SELECT COUNT(*) FROM Model2Board WHERE boardName ='"+brdName+"' ";
		//검색어가 있는 경우
		if(map.get("searchWord") != null) {
			query += " AND " + map.get("searchField") +" "
					+" LIKE '%" + map.get("searchWord") + "%' ";
		}
		
		try {
			//정적쿼리문 실행 객체 생성
			stmt = con.createStatement();
			rs = stmt.executeQuery(query);
			rs.next();
			
			//결과값을 변수에 저장
			totalCount = rs.getInt(1);
		}
		catch (Exception e) {
			System.out.println("게시물 수를 구하는 중 예외 발생");
			e.printStackTrace();
		}
		
		return totalCount;
	}
	
	//게시물 출력 관련 메서드
	public List<ProjectBoardDTO> selectList(Map<String, Object> map, String brdName) { 
	    
		//List컬렉션 생성 
        List<ProjectBoardDTO> bbs = new Vector<ProjectBoardDTO>();  

        //Idx의 내림차순으로 게시물 정렬 및 출력
        String query = "SELECT * FROM Model2Board WHERE boardName ='"+brdName+"' "; 
        
        //검색어
        if (map.get("searchWord") != null) {
            query += " AND " + map.get("searchField") + " "
                   + " LIKE '%" + map.get("searchWord") + "%' ";
        }
        query += " ORDER BY idx DESC "; //내림차순 정렬

        try {
            stmt = con.createStatement();    
            rs = stmt.executeQuery(query);  

            //결과 반복
            while (rs.next()) { 
            	
            	//레코드 읽기 dto객체 생성
            	ProjectBoardDTO dto = new ProjectBoardDTO(); 

                dto.setIdx(rs.getString("idx"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));      
                dto.setContent(rs.getString("content"));   
                dto.setPostdate(rs.getDate("postdate"));  
                dto.setOfile(rs.getString("ofile"));           
                dto.setSfile(rs.getString("sfile")); 
                dto.setVisitcount(rs.getInt("visitcount"));  
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
		
	//자유게시판 입력 //sub03
	public int insertWrite(ProjectBoardDTO dto) {

        int result = 0; //확인을 위한 변수

        try {
            //동적 쿼리
            String query = "insert into Model2Board"
                    + "(id, title, content, boardName)"
                    + "values(? , ? , ?, ?)";

            //동적쿼리문
            psmt = con.prepareStatement(query);
            //인파라미터 설정 
            psmt.setString(1, dto.getId());
            psmt.setString(2, dto.getTitle());
            psmt.setString(3, dto.getContent());
            psmt.setString(4, dto.getBoardName());

            result = psmt.executeUpdate();//성공 시 1반환
        }
        catch (Exception e) {
            System.out.println("게시물 입력 중 예외 발생");
            e.printStackTrace();
        }
        return result;
    }
	
	//첨부게시판 입력 //sub04, sub05
  	public int insertFile(ProjectBoardDTO dto) {
  		int applyResult=0;
  		try {
  			//1.쿼리문 작성
  			String query= "INSERT INTO Model2Board( "
  					+ " id, title, content, ofile, sfile, boardName) "
  					+ " VALUES( "
  					+ "?, ?, ?, ?, ?, ?)";
  			
  			//2.prepared객체 생성 및 인파라미터 설정
  			psmt = con.prepareStatement(query);
  			psmt.setString(1, dto.getId());
  			psmt.setString(2, dto.getTitle());
  			psmt.setString(3, dto.getContent());
  			psmt.setString(4, dto.getOfile());
  			psmt.setString(5, dto.getSfile());
  			psmt.setString(6, dto.getBoardName());
  			
  			//3.쿼리 실행
  			applyResult=psmt.executeUpdate();
  		}
  		catch (Exception e) {
  			System.out.println("INSERT중 예외 발생");
  			e.printStackTrace();
  		}
  		return applyResult;
  	}
	
	//상세보기를 위해 특정 일련번호에 해당하는 게시물을 인출한다. 
    public ProjectBoardDTO selectView(String idx) { 
        
    	ProjectBoardDTO dto = new ProjectBoardDTO(); 
        
        String query = "SELECT"
        		+ " idx, B.id, title, content, postdate, ofile, sfile, visitcount, boardName "
        		+ " FROM Model2Board B inner join ProjectMember M "
        		+ " on B.id=M.id "
                + " WHERE idx=?";

        try {
            psmt = con.prepareStatement(query);
            psmt.setString(1, idx);   
            rs = psmt.executeQuery();  
            //일련번호는 중복되지 않으므로 if문에서 처리하면 된다. 
            if (rs.next()) {//ResultSet에서 커서를 이동시켜 레코드를 읽은 후
            	// DTO객체에 레코드의 내용을 추가한다. 
            	dto.setIdx(rs.getString("idx"));
                dto.setId(rs.getString("id"));
                dto.setTitle(rs.getString("title"));  
                dto.setContent(rs.getString("content"));   
                dto.setPostdate(rs.getDate("postdate"));  
                dto.setOfile(rs.getString("ofile"));           
                dto.setSfile(rs.getString("sfile")); 
                dto.setVisitcount(rs.getInt("visitcount")); 
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
    //조회수 증가
    public void updateVisitCnt(String idx) {
    	
    	String query = "UPDATE Model2Board SET "
    			+ " visitcount = visitcount+1 "
    			+ " WHERE idx=?";
    	
    	try {
    		psmt = con.prepareStatement(query);
    		psmt.setString(1, idx);
    		rs = psmt.executeQuery();
    	}
    	catch (Exception e) {
    		System.out.println("게시물 조회수 증가 중 예외 발생");
			e.printStackTrace();
		}
    }
    
    //게시물 수정 //sub03,sub05
  	public int updateEdit(ProjectBoardDTO dto) {
  		
  		int result=0; //확인용 변수
  		
  		try { //쿼리문
  			String query = "UPDATE Model2Board SET " 
  				  	 + " title= ?, content= ?, ofile= ?, sfile= ? "
  				  	 + " WHERE idx=?";
  			
  			psmt = con.prepareStatement(query);
  			psmt.setString(1, dto.getTitle());
  			psmt.setString(2, dto.getContent());
  			psmt.setString(3, dto.getOfile());
  			psmt.setString(4, dto.getSfile());
  			psmt.setString(5, dto.getIdx());
  			//쿼리 실행
  			result = psmt.executeUpdate();
  		}
  		catch (Exception e) {
  			System.out.println("게시물 수정 중 예외 발생");
  			e.printStackTrace();
  		}
  		
  		return result;
  	}
  	/*sub05 수정하기 
  	public int updateEditR(ProjectBoardDTO dto) {
  		
  		int result=0; //확인용 변수
  		
  		try { //쿼리문
  			String query = "UPDATE Model2Board SET " 
  				  	 + " title= ?, content= ?, ofile= ?, sfile= ? "
  				  	 + " WHERE idx=?";
  			
  			psmt = con.prepareStatement(query);
  			psmt.setString(1, dto.getTitle());
  			psmt.setString(2, dto.getContent());
  			psmt.setString(3, dto.getOfile());
  			psmt.setString(4, dto.getSfile());
  			psmt.setString(5, dto.getIdx());
  			//쿼리 실행
  			result = psmt.executeUpdate();
  		}
  		catch (Exception e) {
  			System.out.println("게시물 수정 중 예외 발생");
  			e.printStackTrace();
  		}
  		
  		return result;
  	}*/
  	
  	// 지정한 게시물을 삭제합니다.
    public int deletePost(ProjectBoardDTO dto) { 
        int result = 0;

        try {
            // 쿼리문 템플릿
            String query = "DELETE FROM Model2Board WHERE idx=?"; 

            // 쿼리문 완성
            psmt = con.prepareStatement(query); 
            psmt.setString(1, dto.getIdx()); 

            // 쿼리문 실행
            result = psmt.executeUpdate(); 
        } 
        catch (Exception e) {
            System.out.println("게시물 삭제 중 예외 발생");
            e.printStackTrace();
        }
        
        return result; // 결과 반환
    }
  	
  /*sub05*/
  
}
