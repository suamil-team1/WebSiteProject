package util;

import java.io.File;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class FileUtil {
	
	//파일 업로드
	public static MultipartRequest uploadFile(HttpServletRequest req, String saveDirectory, 
						int maxPostSize) {
		try {
			/*
			파일 업로드 & 서버 저장. 객체의 참조값 반환
			req : request내장객체
			saveDirectory : 디렉토리의 물리적경로, 
			maxPostSize : 파일제한용량, 
			"UTF-8" : 인코딩방식)
			*/
			return new MultipartRequest(req, saveDirectory, maxPostSize, "UTF-8");
		}
		catch(Exception e) {
			e.printStackTrace();
			return null;
		}
	}
	
	//파일 검색 & 다운로드
	
	
	//파일 삭제
	public static void deleteFile(HttpServletRequest req, 
			String directory, String filename) {
		//물리적 경로 획득
		String sDirectory = req.getServletContext().getRealPath(directory);
		
		File file = new File(sDirectory + File.separator + filename);
		if(file.exists()) {
		file.delete();	//존재한다면 삭제
		}
	}
}
