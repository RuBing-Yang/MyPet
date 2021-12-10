package Utils;

public class Group {
    int groupId;
    String groupName;
    String groupIntroduction;
    int groupLeader;
    int groupNumber;
    int groupActivity;

    public Group(int groupId, String groupName, String groupIntroduction, int groupLeader, int groupNumber, int groupActivity) {
        this.groupId = groupId;
        this.groupName = groupName;
        this.groupIntroduction = groupIntroduction;
        this.groupLeader = groupLeader;
        this.groupNumber = groupNumber;
        this.groupActivity = groupActivity;
    }

    public int getGroupId() {
        return groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public String getGroupIntroduction() {
        return groupIntroduction;
    }

    public int getGroupLeader() {
        return groupLeader;
    }

    public int getGroupNumber() {
        return groupNumber;
    }

    public int getGroupActivity() {
        return groupActivity;
    }
}
