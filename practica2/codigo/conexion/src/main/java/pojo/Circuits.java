package pojo;

public class Circuits{
	private String circuitRef;
	private String country;
	private double lng;
	private String name;
	private int alt;
	private String location;
	private int circuitId;
	private double lat;
	private String url;

	public void setCircuitRef(String circuitRef){
		this.circuitRef = circuitRef;
	}

	public String getCircuitRef(){
		return circuitRef;
	}

	public void setCountry(String country){
		this.country = country;
	}

	public String getCountry(){
		return country;
	}

	public void setLng(double lng){
		this.lng = lng;
	}

	public double getLng(){
		return lng;
	}

	public void setName(String name){
		this.name = name;
	}

	public String getName(){
		return name;
	}

	public void setAlt(int alt){
		this.alt = alt;
	}

	public int getAlt(){
		return alt;
	}

	public void setLocation(String location){
		this.location = location;
	}

	public String getLocation(){
		return location;
	}

	public void setCircuitId(int circuitId){
		this.circuitId = circuitId;
	}

	public int getCircuitId(){
		return circuitId;
	}

	public void setLat(double lat){
		this.lat = lat;
	}

	public double getLat(){
		return lat;
	}

	public void setUrl(String url){
		this.url = url;
	}

	public String getUrl(){
		return url;
	}

	@Override
 	public String toString(){
		return 
			"Circuits{" + 
			"circuitRef = '" + circuitRef + '\'' + 
			",country = '" + country + '\'' + 
			",lng = '" + lng + '\'' + 
			",name = '" + name + '\'' + 
			",alt = '" + alt + '\'' + 
			",location = '" + location + '\'' + 
			",circuitId = '" + circuitId + '\'' + 
			",lat = '" + lat + '\'' + 
			",url = '" + url + '\'' + 
			"}";
		}
}
