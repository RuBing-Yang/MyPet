package Utils;

public class Group {
    int groupId;
    String groupName;
    String groupDate;
    String groupIntroduction;
    int groupLeader;
    int groupActivity;

    public Group(int groupId, String groupName, String groupDate, String groupIntroduction, int groupLeader, int groupActivity) {
        this.groupId = groupId;
        this.groupName = groupName;
        this.groupDate = groupDate;
        this.groupIntroduction = groupIntroduction;
        this.groupLeader = groupLeader;
        this.groupActivity = groupActivity;
    }

    public int getGroupId() {
        return groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public String getGroupDate() {
        return groupDate;
    }

    public String getGroupIntroduction() {
        return groupIntroduction;
    }

    public int getGroupLeader() {
        return groupLeader;
    }

    public int getGroupActivity() {
        return groupActivity;
    }
}
