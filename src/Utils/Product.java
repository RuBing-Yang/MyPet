package Utils;

public class Product {
    int productId;
    String productName;
    String productPhoto;
    String productIntroduction;
    double productPrice;
    String productLink;

    public Product(int productId, String productName, String productPhoto, String productIntroduction, double productPrice, String productLink) {
        this.productId = productId;
        this.productName = productName;
        this.productPhoto = productPhoto;
        this.productIntroduction = productIntroduction;
        this.productPrice = productPrice;
        this.productLink = productLink;
    }

    public int getProductId() {
        return productId;
    }

    public String getProductName() {
        return productName;
    }

    public String getProductPhoto() {
        return productPhoto;
    }

    public String getProductIntroduction() {
        return productIntroduction;
    }

    public double getProductPrice() {
        return productPrice;
    }

    public String getProductLink() {
        return productLink;
    }

    @Override
    public String toString() {
        return "Product{" +
                "productId=" + productId +
                ", productName='" + productName + '\'' +
                ", productPhoto='" + productPhoto + '\'' +
                ", productIntroduction='" + productIntroduction + '\'' +
                ", productPrice=" + productPrice +
                ", productLink='" + productLink + '\'' +
                '}';
    }
}
