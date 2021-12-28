package metier;

import java.util.Date;

public class Notification {
	private String id;
	private User user;
	private Date receivedDate;
	private String content;
	
	public Notification(String id, User user, Date receivedDate, String content) {
		this.id = id;
		this.user = user;
		this.receivedDate = receivedDate;
		this.content = content;
	}
	
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Date getReceivedDate() {
		return receivedDate;
	}
	public void setReceivedDate(Date receivedDate) {
		this.receivedDate = receivedDate;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
	
}
