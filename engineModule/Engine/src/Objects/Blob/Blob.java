package Objects.Blob;

import Objects.Api.MagitObject;


public class Blob extends MagitObject {

    public Blob(String _content) {
        super(_content);
    }
    public void setContent(String content){
        this.content = content;
    }
}
