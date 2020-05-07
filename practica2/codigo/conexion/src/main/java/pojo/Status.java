package pojo;

import com.google.gson.annotations.SerializedName;

public class Status{

	@SerializedName("statusId")
	private int statusId;

	@SerializedName("status")
	private String status;

	public void setStatusId(int statusId){
		this.statusId = statusId;
	}

	public int getStatusId(){
		return statusId;
	}

	public void setStatus(String status){
		this.status = status;
	}

	public String getStatus(){
		return status;
	}
}