package Utils;

public class Doctor {
    int doctorId;
    String doctorName;
    String doctorPhoto;
    int doctorWorkYears;
    String doctorIntroduction;
    String doctorContact;

    public Doctor(int doctorId, String doctorName, String doctorPhoto, int doctorWorkYears, String doctorIntroduction, String doctorContact) {
        this.doctorId = doctorId;
        this.doctorName = doctorName;
        this.doctorPhoto = doctorPhoto;
        this.doctorWorkYears = doctorWorkYears;
        this.doctorIntroduction = doctorIntroduction;
        this.doctorContact = doctorContact;
    }

    public int getDoctorId() {
        return doctorId;
    }

    public String getDoctorName() {
        return doctorName;
    }

    public String getDoctorPhoto() {
        return doctorPhoto;
    }

    public int getDoctorWorkYears() {
        return doctorWorkYears;
    }

    public String getDoctorIntroduction() {
        return doctorIntroduction;
    }

    public String getDoctorContact() {
        return doctorContact;
    }

    @Override
    public String toString() {
        return "Doctor{" +
                "doctorId=" + doctorId +
                ", doctorName='" + doctorName + '\'' +
                ", doctorPhoto='" + doctorPhoto + '\'' +
                ", doctorWorkYears=" + doctorWorkYears +
                ", doctorIntroduction='" + doctorIntroduction + '\'' +
                ", doctorContact='" + doctorContact + '\'' +
                '}';
    }
}
