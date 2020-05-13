package pojo;



public class LapTimes{


	private int raceId;


	private int milliseconds;


	private int driverId;


	private int lap;


	private int position;

	private String time;

	public void setRaceId(int raceId){
		this.raceId = raceId;
	}

	public int getRaceId(){
		return raceId;
	}

	public void setMilliseconds(int milliseconds){
		this.milliseconds = milliseconds;
	}

	public int getMilliseconds(){
		return milliseconds;
	}

	public void setDriverId(int driverId){
		this.driverId = driverId;
	}

	public int getDriverId(){
		return driverId;
	}

	public void setLap(int lap){
		this.lap = lap;
	}

	public int getLap(){
		return lap;
	}

	public void setPosition(int position){
		this.position = position;
	}

	public int getPosition(){
		return position;
	}

	public void setTime(String time){
		this.time = time;
	}

	public String getTime(){
		return time;
	}

	@Override
 	public String toString(){
		return 
			"LapTimes{" + 
			"raceId = '" + raceId + '\'' + 
			",milliseconds = '" + milliseconds + '\'' + 
			",driverId = '" + driverId + '\'' + 
			",lap = '" + lap + '\'' + 
			",position = '" + position + '\'' + 
			",time = '" + time + '\'' + 
			"}";
		}
}