package model.shopboard;

import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import connect.JDBConnect;

public class basketboardDAO extends JDBConnect{

	public basketboardDAO() {} //기본생성자
	public basketboardDAO(ServletContext application) {
        super(application);
    }
	
	//게시물 출력 관련 메서드
			public List<basketboardDTO> selectList(Map<String, Object> map) { 
			    
				//List컬렉션 생성 
		        List<basketboardDTO> bbs = new Vector<basketboardDTO>();  

		        //pNum의 내림차순으로 게시물 정렬 및 출력
		        String query = " select "
		        		+" imgfile, pname, price, point, eaNum,delivery,delVer "
		        		+" from product P inner join basket B "
		        		+" on P.pNum=B.pNum "
		                +" where idx=?";

		        try {
		            stmt = con.createStatement();    
		            rs = stmt.executeQuery(query);  

		            //결과 반복
		            while (rs.next()) { 
		            	
		            	//레코드 읽기 dto객체 생성
		            	basketboardDTO dto = new basketboardDTO(); 

		            	dto.setpNum(rs.getString("pNum"));
		                dto.setId(rs.getString("id"));
		                dto.setEaNum(rs.getString("eaNum"));   
		                dto.setSump(rs.getString("sump"));   
		                dto.setDelivery(rs.getString("delivery"));
		                dto.setDelVer(rs.getString("delVer"));
		                
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
