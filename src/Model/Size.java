package Model;

public class Size {
    String eu;
    String uk;
    String usMale;
    String usFemale;
    String japan;


    public Size(String eu, String uk, String usMale, String usFemale, String japan) {
        this.eu = eu;
        this.uk = uk;
        this.usMale = usMale;
        this.usFemale = usFemale;
        this.japan = japan;
    }

    public String getEu() {
        return eu;
    }

    public String getUsMale() {
        return usMale;
    }

    public String getUsFemale() {
        return usFemale;
    }

    public String getUk() {
        return uk;
    }

    public String getJapan() {
        return japan;
    }
}
