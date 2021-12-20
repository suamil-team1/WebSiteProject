package member;

import javax.servlet.ServletContext;

import connect.JDBConnect;
/*
DAO(Data Access Object): 실제 데이터베이스에 접근하여
	여러 가지 CRUD작업을 하기 위한 객체.
*/

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
	
	
	/*
	 사용자가 입력한 아이디, 패스워드를 통해 회원테이블을 확인한 후
	 존재하는 정보인 경우 DTO 객체에 그 정보를 담아 반환한다.
	 */
	public ProjectMemberDTO getMemberDTO(String uid, String upass) {
		ProjectMemberDTO dto = new ProjectMemberDTO();
		//회원로그인을 위한 쿼리문 작성
		String query = "SELECT * FROM Projectmember WHERE id =? AND pass=?";
		
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
}
