package pojo;

public class ConstructorResults{
	private int raceId;
	private int constructorResultsId;
	private int constructorId;
	private int points;
	private Object status;

	public void setRaceId(int raceId){
		this.raceId = raceId;
	}

	public int getRaceId(){
		return raceId;
	}

	public void setConstructorResultsId(int constructorResultsId){
		this.constructorResultsId = constructorResultsId;
	}

	public int getConstructorResultsId(){
		return constructorResultsId;
	}

	public void setConstructorId(int constructorId){
		this.constructorId = constructorId;
	}

	public int getConstructorId(){
		return constructorId;
	}

	public void setPoints(int points){
		this.points = points;
	}

	public int getPoints(){
		return points;
	}

	public void setStatus(Object status){
		this.status = status;
	}

	public Object getStatus(){
		return status;
	}

	@Override
 	public String toString(){
		return 
			"ConstructorResults{" + 
			"raceId = '" + raceId + '\'' + 
			",constructorResultsId = '" + constructorResultsId + '\'' + 
			",constructorId = '" + constructorId + '\'' + 
			",points = '" + points + '\'' + 
			",status = '" + status + '\'' + 
			"}";
		}
}
