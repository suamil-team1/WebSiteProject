
package connect;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.servlet.ServletContext;

public class JDBConnect {
	public Connection con;
	public Statement stmt;
	public PreparedStatement psmt;
	public ResultSet rs;
	
	/* Java 파일이 변경되면 서버를 재가동 해야하는데 서버를 재시작 하는것은
	 	비용이 많이 드는 일이기 때문에 이렇게 하드코딩으로 박제하는 일은 잘 없다.
	 	대부분은 따로 빼서 입력한다. */
	//기본 생성자
	public JDBConnect() {
		try	{
			//오라클 드라이버 로드
			Class.forName("org.mariadb.jdbc.Driver");
			//커넥션 URL 생성
			String url = "jdbc:mariadb://localhost:3306/hj890825";
			String id = "hj890825";
			String pwd = "varan@1350";
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	//두번째 생성자
	public JDBConnect(String driver, String url, String id, String pwd) {
		try	{
			//JDBC 드라이버 로드
			Class.forName(driver);
			//DB에 연결
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}	
	
	//세번째 생성자(인자가 하나)
	public JDBConnect(ServletContext application) {
		
		//web.xml에 저장된 오라클 접속정보를 얻어온다.
		String driver = application.getInitParameter("MariaDBDriver");
		String url = application.getInitParameter("MariaDBURL");
		String id = application.getInitParameter("MariaDBId");
		String pwd = application.getInitParameter("MariaDBPwd");
		
		try	{
			//JDBC 드라이버 로드
			Class.forName(driver);
			//DB에 연결
			con = DriverManager.getConnection(url, id, pwd);
			
			System.out.println("DB 연결 성공");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}	
	
	//연결 해제(자원 반납)
	public void close() {
		try {
			if(rs !=null) rs.close();
			if(stmt !=null) stmt.close();
			if(psmt !=null) psmt.close();
			if(con !=null) con.close();
			
			System.out.println("JDBC 자원 해제");
		}
		catch(Exception e) {
			e.printStackTrace();
		}
	}
}