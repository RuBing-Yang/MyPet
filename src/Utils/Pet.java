package Utils;

public class Pet {
    int petId;
    String petVariety;
    String petName;
    int petAge;
    String petGender;
    String petRemarks;
    Person owner = null;
    int rescue;

    public Pet(int petId, String petVariety, String petName, int petAge, String petGender, String petRemarks, int rescue) {
        this.petId = petId;
        this.petVariety = petVariety;
        this.petName = petName;
        this.petAge = petAge;
        this.petGender = petGender;
        this.petRemarks = petRemarks;
        this.rescue = rescue;
    }


    public void setOwner(Person owner) {
        this.owner = owner;
    }


    public void setOwner(int id, String name) {
        this.owner = new Person(id, name);
    }

    public Person getOwner() {
        return owner;
    }

    public int getPetId() {
        return petId;
    }

    public String getPetVariety() {
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

    public boolean needRescue() {
        return (rescue==1);
    }

    public String variety2Chinese()
    {
        switch (petVariety) {
            case "cat":
                return "猫";
            case "dog":
                return "狗";
            case "bird":
                return "鸟类";
            case "cold":
                return  "冷血动物";
            case "other":
                return "其他";
            default:
                return "--";
        }
    }
}
