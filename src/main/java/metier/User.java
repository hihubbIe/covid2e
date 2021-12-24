package metier;

public class User {
	
	private String name;
	private String prenom;
	private String role;
	
	public User(String name, String prenom, String role) {
		this.name=name;
		this.prenom=prenom;
		this.role=role;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPrenom() {
		return prenom;
	}
	public void setPrenom(String prenom) {
		this.prenom = prenom;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	

}
