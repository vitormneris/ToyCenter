package br.edu.toycenter.model;

import java.util.List;

public class Category {
	private int categoryCode;
	private String categoryName;
	private String categoryImage;
	
	private List<Toy> toys;

	public Category() {
		super();
	}
	
	public Category(int categoryCode) {
		super();
		this.categoryCode = categoryCode;
	}
	
	public Category(int categoryCode, String categoryName, String categoryImage) {
		super();
		this.categoryCode = categoryCode;
		this.categoryName = categoryName;
		this.categoryImage = categoryImage;
	}

	public Category(int categoryCode, String categoryName, String categoryImage, List<Toy> toys) {
		super();
		this.categoryCode = categoryCode;
		this.categoryName = categoryName;
		this.categoryImage = categoryImage;
		this.toys = toys;
	}

	public int getCategoryCode() {
		return categoryCode;
	}

	public void setCategoryCode(int categoryCode) {
		this.categoryCode = categoryCode;
	}

	public String getCategoryName() {
		return categoryName;
	}

	public void setCategoryName(String categoryName) {
		this.categoryName = categoryName;
	}

	public String getCategoryImage() {
		return categoryImage;
	}

	public void setCategoryImage(String categoryImage) {
		this.categoryImage = categoryImage;
	}

	public List<Toy> getCategoryToys() {
		return toys;
	}
	
	public void addToy(Toy toy) {
		toys.add(toy);
	}

	@Override
	public String toString() {
		return "Category [categoryCode=" + categoryCode + ", categoryName=" + categoryName + ", categoryImage=" + categoryImage + "]";
	}
}