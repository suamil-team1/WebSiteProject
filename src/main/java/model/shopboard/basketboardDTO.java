package model.shopboard;

public class basketboardDTO {
	private String pNum;
	private String id;
	private String eaNum;
	private String sump;
	private String delivery;
	private String delVer;
	
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
	public String getpNum() {
		return pNum;
	}
	public void setpNum(String pNum) {
		this.pNum = pNum;
	}
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
}