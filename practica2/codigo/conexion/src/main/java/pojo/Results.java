package pojo;

import com.google.gson.annotations.SerializedName;

public class Results{

	@SerializedName("raceId")
	private int raceId;

	@SerializedName("milliseconds")
	private int milliseconds;

	@SerializedName("resultId")
	private int resultId;

	@SerializedName("constructorId")
	private int constructorId;

	@SerializedName("laps")
	private int laps;

	@SerializedName("positionOrder")
	private int positionOrder;

	@SerializedName("points")
	private int points;

	@SerializedName("number")
	private int number;

	@SerializedName("positionText")
	private String positionText;

	@SerializedName("fastestLapSpeed")
	private String fastestLapSpeed;

	@SerializedName("driverId")
	private int driverId;

	@SerializedName("statusId")
	private int statusId;

	@SerializedName("grid")
	private int grid;

	@SerializedName("rank")
	private int rank;

	@SerializedName("position")
	private int position;

	@SerializedName("time")
	private String time;

	@SerializedName("fastestLapTime")
	private String fastestLapTime;

	@SerializedName("fastestLap")
	private int fastestLap;

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

	public void setResultId(int resultId){
		this.resultId = resultId;
	}

	public int getResultId(){
		return resultId;
	}

	public void setConstructorId(int constructorId){
		this.constructorId = constructorId;
	}

	public int getConstructorId(){
		return constructorId;
	}

	public void setLaps(int laps){
		this.laps = laps;
	}

	public int getLaps(){
		return laps;
	}

	public void setPositionOrder(int positionOrder){
		this.positionOrder = positionOrder;
	}

	public int getPositionOrder(){
		return positionOrder;
	}

	public void setPoints(int points){
		this.points = points;
	}

	public int getPoints(){
		return points;
	}

	public void setNumber(int number){
		this.number = number;
	}

	public int getNumber(){
		return number;
	}

	public void setPositionText(String positionText){
		this.positionText = positionText;
	}

	public String getPositionText(){
		return positionText;
	}

	public void setFastestLapSpeed(String fastestLapSpeed){
		this.fastestLapSpeed = fastestLapSpeed;
	}

	public String getFastestLapSpeed(){
		return fastestLapSpeed;
	}

	public void setDriverId(int driverId){
		this.driverId = driverId;
	}

	public int getDriverId(){
		return driverId;
	}

	public void setStatusId(int statusId){
		this.statusId = statusId;
	}

	public int getStatusId(){
		return statusId;
	}

	public void setGrid(int grid){
		this.grid = grid;
	}

	public int getGrid(){
		return grid;
	}

	public void setRank(int rank){
		this.rank = rank;
	}

	public int getRank(){
		return rank;
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

	public void setFastestLapTime(String fastestLapTime){
		this.fastestLapTime = fastestLapTime;
	}

	public String getFastestLapTime(){
		return fastestLapTime;
	}

	public void setFastestLap(int fastestLap){
		this.fastestLap = fastestLap;
	}

	public int getFastestLap(){
		return fastestLap;
	}

	@Override
 	public String toString(){
		return 
			"Results{" + 
			"raceId = '" + raceId + '\'' + 
			",milliseconds = '" + milliseconds + '\'' + 
			",resultId = '" + resultId + '\'' + 
			",constructorId = '" + constructorId + '\'' + 
			",laps = '" + laps + '\'' + 
			",positionOrder = '" + positionOrder + '\'' + 
			",points = '" + points + '\'' + 
			",number = '" + number + '\'' + 
			",positionText = '" + positionText + '\'' + 
			",fastestLapSpeed = '" + fastestLapSpeed + '\'' + 
			",driverId = '" + driverId + '\'' + 
			",statusId = '" + statusId + '\'' + 
			",grid = '" + grid + '\'' + 
			",rank = '" + rank + '\'' + 
			",position = '" + position + '\'' + 
			",time = '" + time + '\'' + 
			",fastestLapTime = '" + fastestLapTime + '\'' + 
			",fastestLap = '" + fastestLap + '\'' + 
			"}";
		}
}