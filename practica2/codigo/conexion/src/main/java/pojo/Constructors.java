package pojo;

public class Constructors{
	private String nationality;
	private String constructorRef;
	private String name;
	private int constructorId;
	private String url;

	public void setNationality(String nationality){
		this.nationality = nationality;
	}

	public String getNationality(){
		return nationality;
	}

	public void setConstructorRef(String constructorRef){
		this.constructorRef = constructorRef;
	}

	public String getConstructorRef(){
		return constructorRef;
	}

	public void setName(String name){
		this.name = name;
	}

	public String getName(){
		return name;
	}

	public void setConstructorId(int constructorId){
		this.constructorId = constructorId;
	}

	public int getConstructorId(){
		return constructorId;
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
			"Constructors{" + 
			"nationality = '" + nationality + '\'' + 
			",constructorRef = '" + constructorRef + '\'' + 
			",name = '" + name + '\'' + 
			",constructorId = '" + constructorId + '\'' + 
			",url = '" + url + '\'' + 
			"}";
		}
}
