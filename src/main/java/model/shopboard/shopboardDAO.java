package model.shopboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import connect.JDBConnect;
import model.projectboard.ProjectBoardDTO;

public class shopboardDAO extends JDBConnect{
	
	public shopboardDAO() {} //기본생성자
	public shopboardDAO(ServletContext application) {
        super(application);
    }
	//게시물의 갯수 카운트하기
		public int selectCount(Map<String, Object> map){
			int totalCount=0;//카운트 변수
			
			//쿼리문 작성
			String query = " SELECT COUNT(*) FROM product ";
			//검색어가 있는 경우
			if(map.get("searchWord") != null) {
				query += " WHERE " + map.get("searchField") +" "
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
		public List<shopboardDTO> selectList(Map<String, Object> map) { 
		    
			//List컬렉션 생성 
	        List<shopboardDTO> bbs = new Vector<shopboardDTO>();  

	        //pNum의 내림차순으로 게시물 정렬 및 출력
	        String query = "SELECT * FROM product "; 
	        
	        //검색어
	        if (map.get("searchWord") != null) {
	            query += " WHERE " + map.get("searchField")
	                   + " LIKE '%" + map.get("searchWord") + "%' ";
	        }
	        query += " ORDER BY pNum DESC "; //내림차순 정렬

	        try {
	            stmt = con.createStatement();    
	            rs = stmt.executeQuery(query);  

	            //결과 반복
	            while (rs.next()) { 
	            	
	            	//레코드 읽기 dto객체 생성
	            	shopboardDTO dto = new shopboardDTO(); 

	            	dto.setPname(rs.getString("pname"));
	                dto.setPcontent(rs.getString("pcontent"));
	                //dto.setIdx(rs.getString("idx"));   
	                dto.setpNum(rs.getString("pNum"));      
	                dto.setPrice(rs.getString("price"));   
	                dto.setImgfile(rs.getString("imgfile"));
	                dto.setPoint(rs.getString("point"));
	                
	                bbs.add(dto); //dto에 추가  
	            }
	        } 
	        catch (Exception e) {
	            System.out.println("게시물 조회 중 예외 발생");
	            e.printStackTrace();
	        }
	        return bbs;
	    }
		
		//상세보기를 위해 특정 일련번호에 해당하는 게시물을 인출한다. 
	    public shopboardDTO selectView(String pNum) { 
	        
	    	shopboardDTO dto = new shopboardDTO(); 
	        
	        String query = "select"
	        		+ " pNum, pname, pcontent,price,point,imgfile "
	        		+ " from product "
	                + " WHERE pNum=?";
	        
	        try {
	            psmt = con.prepareStatement(query);
	            psmt.setString(1, pNum);   
	            rs = psmt.executeQuery();  
	            //일련번호는 중복되지 않으므로 if문에서 처리하면 된다. 
	            if (rs.next()) {//ResultSet에서 커서를 이동시켜 레코드를 읽은 후
	                //dto.setIdx(rs.getString("idx"));   
	            	dto.setPname(rs.getString("pname"));
	                dto.setPcontent(rs.getString("pcontent"));
	                dto.setpNum(rs.getString("pNum"));      
	                dto.setPrice(rs.getString("price"));   
	                dto.setImgfile(rs.getString("imgfile"));
	                dto.setPoint(rs.getString("point"));
	            }
	        } 
	        catch (Exception e) {
	            System.out.println("게시물 상세보기 중 예외 발생");
	            e.printStackTrace();
	        }
	        
	        return dto; 
	    }
	  //게시물 출력 관련 메서드
	    public shopboardDTO selectBasket(String pNum) { 
		    
			shopboardDTO dto = new shopboardDTO(); 

	        //pNum의 내림차순으로 게시물 정렬 및 출력
	        String query = " select "
	        		+" imgfile, pname, price, point, eaNum,delivery,delVer,sumP "
	        		+" from product P inner join basket B "
	        		+" on P.pNum=B.pNum "
	                +" where P.pNum=?";

	        try {
	        	psmt = con.prepareStatement(query);
	            psmt.setString(1, pNum);   
	            rs = psmt.executeQuery();  
	            //결과 반복
	            while (rs.next()) { 
	            	dto.setpNum(rs.getString("pNum"));
	            	dto.setPname(rs.getString("pname"));
	            	dto.setImgfile(rs.getString("imgfile"));
	            	dto.setPrice(rs.getString("price"));
	            	dto.setPoint(rs.getString("point"));
	                dto.setEaNum(rs.getString("eaNum"));   
	                dto.setSump(rs.getString("sump"));   
	                dto.setDelivery(rs.getString("delivery"));
	                dto.setDelVer(rs.getString("delVer"));
	            }
	        } 
	        catch (Exception e) {
	            System.out.println("게시물 상세보기 중 예외 발생");
	            e.printStackTrace();
	        }
	        
	        return dto; 
		}
		
		
	    
		
}
