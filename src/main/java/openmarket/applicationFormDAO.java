package openmarket;

import javax.servlet.ServletContext;

import connect.JDBConnect;
import member.ProjectMemberDTO;

public class applicationFormDAO extends JDBConnect {
	//인자가 4개인 부모의 생성자를 호출하여 연결한다.
	public applicationFormDAO(String driver, String url, String id, String pwd) {
		super(driver, url, id, pwd);
	}
	//application 내장 객체만 매개변수로 받아 부모로 전달하는 생성자
	public applicationFormDAO(ServletContext application) {
		super(application);
	}
	
	public applicationFormDTO sendnSave(String flag) {
		applicationFormDTO dto = new applicationFormDTO();
		
		//int result = 0;
		String query = "";
		
		try {
			if (flag == "1") {
				query = " INSERT INTO applicationForm"
						+ " (client, adrress, tellnum, mobile, email,"
						+ " content1, content2, targetdate, sort, etc) "
						+ " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
				psmt = con.prepareStatement(query);
				
				psmt.setString(1, dto.getClient());
				psmt.setString(2, dto.getAdrress());
				psmt.setString(3, dto.getTellnum());
				psmt.setString(4, dto.getMobile());
				psmt.setString(5, dto.getEmail());
				psmt.setString(6, dto.getContent1());
				psmt.setString(7, dto.getContent2());
				psmt.setString(8, dto.getTargetdate());
				psmt.setString(9, dto.getSort());
				psmt.setString(10, dto.getEtc());
			}
			else {
				query = " INSERT INTO applicationForm"
						+ " (client, difficulty, device, tellnum, mobile, "
						+ "	email, ctype, area, targetdate, sort, etc) "
						+ " VALUES ( ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?) ";
				psmt = con.prepareStatement(query);
				
				psmt.setString(1, dto.getClient());
				psmt.setString(2, dto.getDifficulty());
				psmt.setString(3, dto.getDevice());
				psmt.setString(4, dto.getTellnum());
				psmt.setString(5, dto.getMobile());
				psmt.setString(6, dto.getEmail());
				psmt.setString(7, dto.getContent1());
				psmt.setString(8, dto.getContent2());
				psmt.setString(9, dto.getTargetdate());
				psmt.setString(10, dto.getSort());
				psmt.setString(11, dto.getEtc());
			}
			
			//result = psmt.executeUpdate(); 
			//con.commit();
		}
		catch (Exception e) {
			System.out.println("신청 과정 중 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
}
