package pojo;

import com.google.gson.annotations.SerializedName;

public class PitStop{

	@SerializedName("duration")
	private String duration;

	@SerializedName("raceId")
	private int raceId;

	@SerializedName("milliseconds")
	private int milliseconds;

	@SerializedName("driverId")
	private int driverId;

	@SerializedName("stop")
	private int stop;

	@SerializedName("lap")
	private int lap;

	@SerializedName("time")
	private String time;

	public void setDuration(String duration){
		this.duration = duration;
	}

	public String getDuration(){
		return duration;
	}

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

	public void setStop(int stop){
		this.stop = stop;
	}

	public int getStop(){
		return stop;
	}

	public void setLap(int lap){
		this.lap = lap;
	}

	public int getLap(){
		return lap;
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
			"PitStop{" + 
			"duration = '" + duration + '\'' + 
			",raceId = '" + raceId + '\'' + 
			",milliseconds = '" + milliseconds + '\'' + 
			",driverId = '" + driverId + '\'' + 
			",stop = '" + stop + '\'' + 
			",lap = '" + lap + '\'' + 
			",time = '" + time + '\'' + 
			"}";
		}
}