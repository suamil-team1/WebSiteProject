package model.shopboard;


public class shopboardDTO {

	//private String idx;
	private String pname;
    private String pcontent;
    private String pNum;
    private String price;
    private String imgfile;
    private String point;
    
    private String id;
	private String eaNum;
	private String sump;
	private String delivery;
	private String delVer;
    
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getEaNum() {
		return eaNum;
	}
	public void setEaNum(String eaNum) {
		this.eaNum = eaNum;
	}
	public String getSump() {
		return sump;
	}
	public void setSump(String sump) {
		this.sump = sump;
	}
	public String getDelivery() {
		return delivery;
	}
	public void setDelivery(String delivery) {
		this.delivery = delivery;
	}
	public String getDelVer() {
		return delVer;
	}
	public void setDelVer(String delVer) {
		this.delVer = delVer;
	}
	
    /*
    public String getIdx() {
		return idx;
	}
	public void setIdx(String idx) {
		this.idx = idx;
	}
	*/
    public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcontent() {
		return pcontent;
	}
	public void setPcontent(String pcontent) {
		this.pcontent = pcontent;
	}
	public String getpNum() {
		return pNum;
	}
	public void setpNum(String pNum) {
		this.pNum = pNum;
	}
	public String getPrice() {
		return price;
	}
	public void setPrice(String price) {
		this.price = price;
	}
	public String getImgfile() {
		return imgfile;
	}
	public void setImgfile(String imgfile) {
		this.imgfile = imgfile;
	}
	public String getPoint() {
		return point;
	}
	public void setPoint(String point) {
		this.point = point;
	}
}
