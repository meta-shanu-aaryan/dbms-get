package com.metacube;

public class Image {
    private String imageURL;
    private int ImageId;

    

    public Image(String imageURL, int imageId) {
        this.imageURL = imageURL;
        ImageId = imageId;
    }

    
    public String getImageURL() {
        return imageURL;
    }
    public int getImageId() {
        return ImageId;
    }

    
}
