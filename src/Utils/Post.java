package Utils;

public class Post {
    int postId;
    String postTitle;
    String postContext;
    String postPlace;
    int postLikesNum;
    int postPersonId;

    public Post(int postId, String postTitle, String postContext, String postPlace, int postLikesNum, int postPersonId) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.postContext = postContext;
        this.postPlace = postPlace;
        this.postLikesNum = postLikesNum;
        this.postPersonId = postPersonId;
    }

    public int getPostId() {
        return postId;
    }

    public String getPostTitle() {
        return postTitle;
    }

    public String getPostContext() {
        return postContext;
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
}
