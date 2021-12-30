package metier;

public class Lieu {

	
	private String name;
	private int num;
	private String street;
	private String zipcode;
	private String city;
	private String country;
	private String coord;
	
	
	
	public Lieu(int num, String street, String zipcode, String city, String country) {
		super();
		this.num = num;
		this.street = street;
		this.zipcode = zipcode;
		this.city = city;
		this.country = country;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
	public String getStreet() {
		return street;
	}
	public void setStreet(String street) {
		this.street = street;
	}
	public String getZipcode() {
		return zipcode;
	}
	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCountry() {
		return country;
	}
	public void setCountry(String country) {
		this.country = country;
	}
	public String getCoord() {
		return coord;
	}
	public void setCoord(String coord) {
		this.coord = coord;
	}
	
	
	
	
}
