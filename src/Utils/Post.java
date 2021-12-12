package Utils;

public class Post {
    int postId;
    String postTitle;
    String postIntro;
    String postContext;
    String postDate;
    String postPlace;
    int postPersonId;
    int postPetId;

    public Post(int postId, String postTitle, String postIntro, String postContext, String postDate, String postPlace, int postPersonId, int postPetId) {
        this.postId = postId;
        this.postTitle = postTitle;
        this.postIntro = postIntro;
        this.postContext = postContext;
        this.postDate = postDate;
        this.postPlace = postPlace;
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

    public String getPostDate() {
        return postDate;
    }

    public String getPostPlace() {
        return postPlace;
    }

    public int getPostPersonId() {
        return postPersonId;
    }

    public int getPostPetId() {
        return postPetId;
    }
}
