package br.edu.toycenter.model;

public class ToyCategory {
	private int toyCode;
	private int categoryCode;
	

	public ToyCategory() {
		super();
	}

	public ToyCategory(int toyCode, int categoryCode) {
		super();
		this.toyCode = toyCode;
		this.categoryCode = categoryCode;
	}

	public int getToyCode() {
		return toyCode;
	}

	public void setToyCode(int toyCode) {
		this.toyCode = toyCode;
	}

	public int getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}

	@Override
	public String toString() {
		return "Category [toyCode=" + toyCode + ", categoryCode=" + categoryCode + "]";
	}
}