package pojo;

public class ConstructorStandings{
	private int wins;
	private int raceId;
	private String positionText;
	private int constructorId;
	private int constructorStandingsId;
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

	public void setConstructorId(int constructorId){
		this.constructorId = constructorId;
	}

	public int getConstructorId(){
		return constructorId;
	}

	public void setConstructorStandingsId(int constructorStandingsId){
		this.constructorStandingsId = constructorStandingsId;
	}

	public int getConstructorStandingsId(){
		return constructorStandingsId;
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
			"ConstructorStandings{" + 
			"wins = '" + wins + '\'' + 
			",raceId = '" + raceId + '\'' + 
			",positionText = '" + positionText + '\'' + 
			",constructorId = '" + constructorId + '\'' + 
			",constructorStandingsId = '" + constructorStandingsId + '\'' + 
			",position = '" + position + '\'' + 
			",points = '" + points + '\'' + 
			"}";
		}
}
