package br.edu.toycenter.model;

import java.util.List;

public class Category {
	private int categoryCode;
	private String categoryName;
	
	private List<Toy> toys;

	public Category() {
		super();
	}
	
	public Category(int categoryCode) {
		super();
		this.categoryCode = categoryCode;
	}
	
	public Category(int categoryCode, String categoryName) {
		super();
		this.categoryCode = categoryCode;
		this.categoryName = categoryName;
	}

	public Category(int categoryCode, String categoryName, List<Toy> toys) {
		super();
		this.categoryCode = categoryCode;
		this.categoryName = categoryName;
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

	public List<Toy> getCategoryToys() {
		return toys;
	}
	
	public void addToy(Toy toy) {
		toys.add(toy);
	}

	@Override
	public String toString() {
		return "Category [categoryCode=" + categoryCode + ", categoryName=" + categoryName + "]";
	}
}