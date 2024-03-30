package br.edu.toycenter.model;

public class Toy {
	private int toyCode;
	private String toyImage;
	private String toyName;
	private String toyBrand;
	private float toyPrice;
	private String toyDescription;
	private String toyDetails;


	public Toy() {
		super();
	}
	
	public Toy(int toyCode) {
		super();
		this.toyCode = toyCode;
	}

	public Toy(int toyCode, String toyImage, String toyName, String toyBrand, float toyPrice, String toyDescription, String toyDetails) {
		super();
		this.toyCode = toyCode;
		this.toyImage = toyImage;
		this.toyName = toyName;
		this.toyBrand = toyBrand;
		this.toyPrice = toyPrice;
		this.toyDescription = toyDescription;
		this.toyDetails = toyDetails;
	}

	public int getToyCode() {
		return toyCode;
	}

	public void setToyCode(int toyCode) {
		this.toyCode = toyCode;
	}

	public String getToyImage() {
		return toyImage;
	}

	public void setToyImage(String toyImage) {
		this.toyImage = toyImage;
	}

	public String getToyName() {
		return toyName;
	}

	public void setToyName(String toyName) {
		this.toyName = toyName;
	}

	public String getToyBrand() {
		return toyBrand;
	}

	public void setToyBrand(String toyBrand) {
		this.toyBrand = toyBrand;
	}

	public float getToyPrice() {
		return toyPrice;
	}

	public void setToyPrice(float toyPrice) {
		this.toyPrice = toyPrice;
	}

	public String getToyDescription() {
		return toyDescription;
	}

	public void setToyDescription(String toyDescription) {
		this.toyDescription = toyDescription;
	}

	public String getToyDetails() {
		return toyDetails;
	}

	public void setToyDetails(String toyDetails) {
		this.toyDetails = toyDetails;
	}

	@Override
	public String toString() {
		return "Toy [toyCode=" + toyCode + ", toyImage=" + toyImage + ", toyName=" + toyName + ", toyBrand=" + toyBrand
				+ ", toyPrice=" + toyPrice + ", toyDescription=" + toyDescription + ", toyDetails=" + toyDetails + "]";
	}
}