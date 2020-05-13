package pojo;



public class Seasons{


	private int year;
	private String url;

	public void setYear(int year){
		this.year = year;
	}

	public int getYear(){
		return year;
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
			"Seasons{" + 
			"year = '" + year + '\'' + 
			",url = '" + url + '\'' + 
			"}";
		}
}