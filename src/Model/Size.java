package Model;

public class Size {
    private int eu;
    private double uk;
    private double usMale;
    private double usFemale;
    private double japan;


    public Size(int eu, double uk, double usMale, double usFemale, double japan) {
        this.eu = eu;
        this.uk = uk;
        this.usMale = usMale;
        this.usFemale = usFemale;
        this.japan = japan;
    }

    public int getEu() {
        return eu;
    }

    public double getUsMale() {
        return usMale;
    }

    public double getUsFemale() {
        return usFemale;
    }

    public double getUk() {
        return uk;
    }

    public double getJapan() {
        return japan;
    }
}
