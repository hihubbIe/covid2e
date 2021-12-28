package metier;

import java.util.Date;

public class User {
	
	private String pseudo="";
	private String name;
	private String firstName;
	private String role;
	private Date anniversaire=null;

	public User(String name, String prenom, String role) {
		this.name=name;
		this.firstName=prenom;
		this.role=role;
	}
	
	public String getPseudo() {
		return pseudo;
	}

	public void setPseudo(String pseudo) {
		this.pseudo = pseudo;
	}

	public Date getAnniversaire() {
		return anniversaire;
	}

	public void setAnniversaire(Date anniversaire) {
		this.anniversaire = anniversaire;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getFirstName() {
		return firstName;
	}
	public void setFirstName(String prenom) {
		this.firstName = prenom;
	}
	public String getRole() {
		return role;
	}
	public void setRole(String role) {
		this.role = role;
	}
	
	

}
