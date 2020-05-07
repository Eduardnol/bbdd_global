package pojo;

public class Races{
	private String date;
	private int raceId;
	private int round;
	private int year;
	private String name;
	private String time;
	private int circuitId;
	private String url;

	public void setDate(String date){
		this.date = date;
	}

	public String getDate(){
		return date;
	}

	public void setRaceId(int raceId){
		this.raceId = raceId;
	}

	public int getRaceId(){
		return raceId;
	}

	public void setRound(int round){
		this.round = round;
	}

	public int getRound(){
		return round;
	}

	public void setYear(int year){
		this.year = year;
	}

	public int getYear(){
		return year;
	}

	public void setName(String name){
		this.name = name;
	}

	public String getName(){
		return name;
	}

	public void setTime(String time){
		this.time = time;
	}

	public String getTime(){
		return time;
	}

	public void setCircuitId(int circuitId){
		this.circuitId = circuitId;
	}

	public int getCircuitId(){
		return circuitId;
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
			"Races{" + 
			"date = '" + date + '\'' + 
			",raceId = '" + raceId + '\'' + 
			",round = '" + round + '\'' + 
			",year = '" + year + '\'' + 
			",name = '" + name + '\'' + 
			",time = '" + time + '\'' + 
			",circuitId = '" + circuitId + '\'' + 
			",url = '" + url + '\'' + 
			"}";
		}
}
