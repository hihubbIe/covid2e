package metier;

import java.util.Date;

import util.ActiviteDAO;

public class Activite {

	private String id;
	private String name;
	private Lieu address;
	private Date start;
	private Date end;
	
	public Activite(String name, Lieu address, Date start, Date end) {
		this.name = name;
		this.address = address;
		this.start = start;
		this.end = end;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public Lieu getAddress() {
		return address;
	}

	public void setAddress(Lieu address) {
		this.address = address;
	}

	public Date getStart() {
		return start;
	}

	public void setStart(Date start) {
		this.start = start;
	}

	public Date getEnd() {
		return end;
	}

	public void setEnd(Date end) {
		this.end = end;
	}
	
	
	
	
	
	
	
}
