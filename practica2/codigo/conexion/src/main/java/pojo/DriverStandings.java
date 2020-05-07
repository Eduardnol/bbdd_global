package pojo;

public class DriverStandings{
	private int wins;
	private int raceId;
	private String positionText;
	private int driverId;
	private int driverStandingsId;
	private int position;
	private int points;

	public void setWins(int wins){
		this.wins = wins;
	}

	public int getWins(){
		return wins;
	}

	public void setRaceId(int raceId){
		this.raceId = raceId;
	}

	public int getRaceId(){
		return raceId;
	}

	public void setPositionText(String positionText){
		this.positionText = positionText;
	}

	public String getPositionText(){
		return positionText;
	}

	public void setDriverId(int driverId){
		this.driverId = driverId;
	}

	public int getDriverId(){
		return driverId;
	}

	public void setDriverStandingsId(int driverStandingsId){
		this.driverStandingsId = driverStandingsId;
	}

	public int getDriverStandingsId(){
		return driverStandingsId;
	}

	public void setPosition(int position){
		this.position = position;
	}

	public int getPosition(){
		return position;
	}

	public void setPoints(int points){
		this.points = points;
	}

	public int getPoints(){
		return points;
	}

	@Override
 	public String toString(){
		return 
			"DriverStandings{" + 
			"wins = '" + wins + '\'' + 
			",raceId = '" + raceId + '\'' + 
			",positionText = '" + positionText + '\'' + 
			",driverId = '" + driverId + '\'' + 
			",driverStandingsId = '" + driverStandingsId + '\'' + 
			",position = '" + position + '\'' + 
			",points = '" + points + '\'' + 
			"}";
		}
}
