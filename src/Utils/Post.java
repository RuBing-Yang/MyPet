package Utils;

public class Post {
    int postId;
    String postTitle;
    String postIntro;
    String postContext;
    String postTime;
    String postPlace;
    int postLikesNum;
    int postPersonId;
    int postPetId;

    public Post(int postId, String postTitle, String postIntro, String postContext, String postTime, String postPlace, int postLikesNum, int postPersonId, int postPetId) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.postIntro = postIntro;
        this.postContext = postContext;
        this.postTime = postTime;
        this.postPlace = postPlace;
        this.postLikesNum = postLikesNum;
        this.postPersonId = postPersonId;
        this.postPetId = postPetId;
    }

    public int getPostId() {
        return postId;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public String getPostIntro() {
        return postIntro;
    }

    public String getPostContext() {
        return postContext;
    }

    public String getPostTime() {
        return postTime;
    }

    public String getPostPlace() {
        return postPlace;
    }

    public int getPostLikesNum() {
        return postLikesNum;
    }

    public int getPostPersonId() {
        return postPersonId;
    }

    public int getPostPetId() {
        return postPetId;
    }
}
