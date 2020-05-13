package pojo;

public class Drivers {


    private int number;

    private String forename;

    private String code;

    private int driverId;

    private String driverRef;

    private String nationality;

    private String surname;


    private String dob;


    private String url;


    public void setNumber(int number) {

        this.number = number;
    }


    public int getNumber() {

        return number;
    }


    public void setForename(String forename) {

        this.forename = forename;
    }


    public String getForename() {

        return forename;
    }


    public void setCode(String code) {

        this.code = code;
    }


    public String getCode() {

        return code;
    }


    public void setDriverId(int driverId) {

        this.driverId = driverId;
    }


    public int getDriverId() {

        return driverId;
    }


    public void setDriverRef(String driverRef) {

        this.driverRef = driverRef;
    }


    public String getDriverRef() {

        return driverRef;
    }


    public void setNationality(String nationality) {

        this.nationality = nationality;
    }


    public String getNationality() {

        return nationality;
    }


    public void setSurname(String surname) {

        this.surname = surname;
    }


    public String getSurname() {

        return surname;
    }


    public void setDob(String dob) {

        this.dob = dob;
    }


    public String getDob() {

        return dob;
    }


    public void setUrl(String url) {

        this.url = url;
    }


    public String getUrl() {

        return url;
    }


    @Override
    public String toString() {

        return
                "Drivers{" +
                        "number = '" + number + '\'' +
                        ",forename = '" + forename + '\'' +
                        ",code = '" + code + '\'' +
                        ",driverId = '" + driverId + '\'' +
                        ",driverRef = '" + driverRef + '\'' +
                        ",nationality = '" + nationality + '\'' +
                        ",surname = '" + surname + '\'' +
                        ",dob = '" + dob + '\'' +
                        ",url = '" + url + '\'' +
                        "}";
    }
}