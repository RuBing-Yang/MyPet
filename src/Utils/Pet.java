package Utils;

public class Pet {
    int petId;
    int petVariety;
    String petName;
    int petAge;
    String petGender;
    String petRemarks;

    public Pet(int petId, int petVariety, String petName, int petAge, String petGender, String petRemarks) {
        this.petId = petId;
        this.petVariety = petVariety;
        this.petName = petName;
        this.petAge = petAge;
        this.petGender = petGender;
        this.petRemarks = petRemarks;
    }

    public int getPetId() {
        return petId;
    }

    public int getPetVariety() {
        return petVariety;
    }

    public String getPetName() {
        return petName;
    }

    public int getPetAge() {
        return petAge;
    }

    public String getPetGender() {
        return petGender;
    }

    public String getPetRemarks() {
        return petRemarks;
    }
}
