package pojo;



public class Qualifying{


	private String q1;

	private int raceId;


	private int number;


	private String q2;


	private String q3;

	private int driverId;

	private int qualifyId;

	private int constructorId;


	private int position;

	public void setQ1(String q1){
		this.q1 = q1;
	}

	public String getQ1(){
		return q1;
	}

	public void setRaceId(int raceId){
		this.raceId = raceId;
	}

	public int getRaceId(){
		return raceId;
	}

	public void setNumber(int number){
		this.number = number;
	}

	public int getNumber(){
		return number;
	}

	public void setQ2(String q2){
		this.q2 = q2;
	}

	public String getQ2(){
		return q2;
	}

	public void setQ3(String q3){
		this.q3 = q3;
	}

	public String getQ3(){
		return q3;
	}

	public void setDriverId(int driverId){
		this.driverId = driverId;
	}

	public int getDriverId(){
		return driverId;
	}

	public void setQualifyId(int qualifyId){
		this.qualifyId = qualifyId;
	}

	public int getQualifyId(){
		return qualifyId;
	}

	public void setConstructorId(int constructorId){
		this.constructorId = constructorId;
	}

	public int getConstructorId(){
		return constructorId;
	}

	public void setPosition(int position){
		this.position = position;
	}

	public int getPosition(){
		return position;
	}

	@Override
 	public String toString(){
		return 
			"Qualifying{" + 
			"q1 = '" + q1 + '\'' + 
			",raceId = '" + raceId + '\'' + 
			",number = '" + number + '\'' + 
			",q2 = '" + q2 + '\'' + 
			",q3 = '" + q3 + '\'' + 
			",driverId = '" + driverId + '\'' + 
			",qualifyId = '" + qualifyId + '\'' + 
			",constructorId = '" + constructorId + '\'' + 
			",position = '" + position + '\'' + 
			"}";
		}
}