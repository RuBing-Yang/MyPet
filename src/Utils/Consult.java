package Utils;

public class Consult {
    int consultId;
    String consultItem;
    int userId;
    int doctorId;
    int consultDirection;

    public Consult(int consultId, String consultItem, int userId, int doctorId, int consultDirection) {
        this.consultId = consultId;
        this.consultItem = consultItem;
        this.userId = userId;
        this.doctorId = doctorId;
        this.consultDirection = consultDirection;
    }

    public int getConsultId() {
        return consultId;
    }

    public String getConsultItem() {
        return consultItem;
    }

    public int getUserId() {
        return userId;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public int getConsultDirection() {
        return consultDirection;
    }
}
