package pojo;



public class Results{


	private int raceId;


	private int milliseconds;


	private int resultId;


	private int constructorId;


	private int laps;


	private int positionOrder;

	private int points;

	private int number;

	private String positionText;


	private String fastestLapSpeed;


	private int driverId;


	private int statusId;


	private int grid;


	private int rank;


	private int position;


	private String time;


	private String fastestLapTime;


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