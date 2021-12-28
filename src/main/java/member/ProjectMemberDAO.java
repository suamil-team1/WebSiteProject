package member;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.servlet.ServletContext;

import connect.JDBConnect;
/*
DAO(Data Access Object): 실제 데이터베이스에 접근하여
	여러 가지 CRUD작업을 하기 위한 객체.
*/
import model.shopboard.shopboardDTO;

//DB 연결을 위한 클래스를 상속한다.
public class ProjectMemberDAO extends JDBConnect {
	//인자가 4개인 부모의 생성자를 호출하여 연결한다.
	public ProjectMemberDAO(String drv, String url, String id, String pw) {
		super(drv, url, id, pw);
	}

	//application 내장 객체만 매개변수로 받아 부모로 전달하는 생성자
	public ProjectMemberDAO(ServletContext application) {
		super(application);
	}
	
	public ProjectMemberDAO(){}
	
	/*
	 사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 확인한 후
	 존재하는 정보인 경우 DTO 객체에 그 정보를 담아 반환한다.
	 */
	public ProjectMemberDTO getMemberDTO(String uid, String upass) {
		ProjectMemberDTO dto = new ProjectMemberDTO();
		//회원로그인을 위한 쿼리문 작성
		String query = "SELECT * FROM ProjectMember WHERE id =? AND pass=?";
		
		try {
			psmt = con.prepareStatement(query);
			//쿼리문에 사용자가 입력한 아이디, 패스워드를 설정
			psmt.setString(1, uid);
			psmt.setString(2, upass);
			//쿼리실행
			rs = psmt.executeQuery();
			
			//회원정보가 존재한다면 DTO 객체에 회원정보를 저장한다.
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setPass(rs.getString("pass"));
				dto.setName(rs.getString(3));
				dto.setEmail(rs.getString(4));
				dto.setRegidate(rs.getString(5));
				dto.setTellNum(rs.getString(6));
				dto.setMobile(rs.getString(7));
				dto.setAddress(rs.getString(8));
				dto.setType(rs.getString(9));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	

	public ProjectMemberDTO getProMemberInfo(String uid, String uname, String uemail) {
		
        
    	ProjectMemberDTO dto = new ProjectMemberDTO();  
        
    	String query = "";
    	if(uid.equals("")) //아이디 찾기
    		query = "SELECT id FROM ProjectMember WHERE name=? AND email=?";
    	else if (uname.equals("") && uemail.equals("")) {
    		query = "SELECT * FROM ProjectMember WHERE id=?";
    	}
    	else //비번찾기
    		query = "SELECT * FROM ProjectMember WHERE id=? AND name=? AND email=?";

        try {
            psmt = con.prepareStatement(query);
            if(uid.equals("")) {
                psmt.setString(1, uname);
                psmt.setString(2, uemail);
            }
            else if (uname.equals("") && uemail.equals("")) {
            	psmt.setString(1, uid);
            }
        	else {
        		psmt.setString(1, uid);     
        		psmt.setString(2, uname);
        		psmt.setString(3, uemail);
        	}
              
            rs = psmt.executeQuery();  
            if (rs.next()) {
                dto.setId(rs.getString("id"));
				dto.setPass(rs.getString(2));
				dto.setName(rs.getString(3));
				dto.setEmail(rs.getString(4));
				dto.setRegidate(rs.getString(5));
				dto.setTellNum(rs.getString(6));
				dto.setMobile(rs.getString(7));
				dto.setAddress(rs.getString(8));
				dto.setType(rs.getString(9));
            }
        }
        catch (Exception e) {
            e.printStackTrace();
        }

        return dto; 
    }
	
	
	public int insertMember(ProjectMemberDTO dto) {
		int result = 0;
		
		try {
			//인파라미터(?물음표)가 있는 쿼리문 작성 => 동적쿼리문
			String query = " INSERT INTO Projectmember (id, pass, name, email, mobile, address) "
						+ " VALUES ( ?, ?, ?, ?, ?, ?) ";
			//동적쿼리문 실행을 위한 prepared 객체 생성
			psmt = con.prepareStatement(query);
			//순서대로 인파라미터 설정
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getEmail());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getAddress());
			
			//쿼리문 실행 : 입력에 성공한다면 1이 반환된다. 실패시 0 반환. 한줄씩 밖에 안들어가니까
			result = psmt.executeUpdate(); //값을 삽입하는 것이므로 executeUpdate사용
		}
		catch (Exception e) {
			System.out.println("회원가입 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public boolean idCheck(String uid) {
		boolean isCorr = false;
		  
		String query = "select id from Projectmember where id = ?";
		  
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, uid);
			rs = psmt.executeQuery();
		 
			if (rs.next()) {
			   isCorr = true;
			}
		     
	    }catch (Exception e) {
	    	e.printStackTrace();
	    }
		  return isCorr;
	}
	
	public int updateMemberInfo(ProjectMemberDTO dto) throws SQLException {
		int result = 0;
		
		String query = "UPDATE Projectmember "
				+ " SET pass=?, name=?, email=?, "
				+ " tellnum=?, mobile=?, address=? "
				+ " WHERE id=? ";
		try {
			psmt = con.prepareStatement(query);
			
			psmt.setString(1, dto.getPass());
			psmt.setString(2, dto.getName());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getTellNum());
			psmt.setString(5, dto.getMobile());
			psmt.setString(6, dto.getAddress());
			psmt.setString(7, dto.getId());
			
			result = psmt.executeUpdate();
			con.commit();
		}
		catch (Exception e) {
			System.out.println("회원정보 수정 중 예외발생");
			e.printStackTrace();
		}
		return result;
	}
	
	public List<ProjectMemberDTO> mamberList(Map<String, Object> map) { 
	    
		//List컬렉션 생성 
        List<ProjectMemberDTO> bbs = new Vector<ProjectMemberDTO>();  
        
        //pNum의 내림차순으로 게시물 정렬 및 출력
        String query = "SELECT * FROM Projectmember "; 
        
        
        try {
            stmt = con.createStatement();    
            rs = stmt.executeQuery(query);  
            
            //결과 반복
            while (rs.next()) { 
            	
            	//레코드 읽기 dto객체 생성
            	ProjectMemberDTO dto = new ProjectMemberDTO(); 
            	
            	dto.setId(rs.getString("id"));
            	dto.setPass(rs.getString(2));
            	dto.setName(rs.getString(3));
            	dto.setEmail(rs.getString(4));
            	dto.setMobile(rs.getString("mobile"));
            	dto.setAddress(rs.getString("address"));
            	dto.setType(rs.getString("type"));
                
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
