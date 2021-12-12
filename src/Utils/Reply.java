package Utils;

public class Reply {
    int replyId;
    String replyDate;
    String replyContext;
    int replyLikesNum;
    int replyPersonId;

    public Reply(int replyId, String replyDate, String replyContext, int replyLikesNum, int replyPersonId) {
        this.replyId = replyId;
        this.replyDate = replyDate;
        this.replyContext = replyContext;
        this.replyLikesNum = replyLikesNum;
        this.replyPersonId = replyPersonId;
    }

    public int getReplyId() {
        return replyId;
    }

    public String getReplyDate() {
        return replyDate;
    }

    public String getReplyContext() {
        return replyContext;
    }

    public int getReplyLikesNum() {
        return replyLikesNum;
    }

    public int getReplyPersonId() {
        return replyPersonId;
    }
}
