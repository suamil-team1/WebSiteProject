package smtp;

import java.io.IOException;
import java.util.Map;
import java.util.Properties;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

public class NaverSMTP {
	private final Properties serverInfo;
	private final Authenticator auth;
	
	public NaverSMTP() {
		serverInfo = new Properties();
		serverInfo.put("mail.smtp.host", "smtp.naver.com");
		serverInfo.put("mail.smtp.part", "465");
		serverInfo.put("mail.smtp.starttls.enable", "true");
		serverInfo.put("mail.smtp.auth", "true");
		serverInfo.put("mail.smtp.debug", "true");
		serverInfo.put("mail.smtp.socketFactory.port", "465");
		serverInfo.put("mail.smtp.socketFactory.class", 
				"javax.net.ssl.SSLSocketFactory");
		serverInfo.put("mail.smtp.socketFactory.fallback", "false");
		
		auth = new Authenticator() {
			protected PasswordAuthentication getPasswordAuthentication() {
				return new PasswordAuthentication("chaerrot", "uljukah486!");
			}
		};
	}
	
	public void emailSending (Map<String, String> mailInfo) throws MessagingException {
		Session session = Session.getInstance(serverInfo, auth);
		session.setDebug(true);
		try {
				MimeMessage msg = new MimeMessage(session);
				msg.setFrom(new InternetAddress("chaerrot@naver.com","마포구립 장애인직업재활센터", "UTF-8"));
				msg.addRecipient(Message.RecipientType.TO, 
									new InternetAddress(mailInfo.get("to")));
				msg.setSubject(mailInfo.get("subject"));
				msg.setContent(mailInfo.get("content"), mailInfo.get("format"));
				
				Transport.send(msg);

			} catch (IOException e) {
				e.printStackTrace();
			}
	}
	
}