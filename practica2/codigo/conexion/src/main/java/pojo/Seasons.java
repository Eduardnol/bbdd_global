package pojo;

import com.google.gson.annotations.SerializedName;

public class Seasons{

	@SerializedName("year")
	private int year;

	@SerializedName("url")
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